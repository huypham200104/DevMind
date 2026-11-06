const functions = require("firebase-functions/v1");
const admin = require("firebase-admin");
const { onCall, HttpsError } = require("firebase-functions/v2/https");
const { defineSecret } = require("firebase-functions/params");


admin.initializeApp();

const groqApiKey = defineSecret("GROQ_API_KEY");
const MAX_CV_FILE_SIZE_BYTES = 5 * 1024 * 1024;

exports.initializeUserRanking = functions.auth.user().onCreate(async (user) => {
  const db = admin.firestore();
  const userRef = db.collection("users").doc(user.uid);
  const rankingRef = db.collection("rankings").doc(user.uid);
  const counterRef = db.collection("metadata").doc("users");
  const now = admin.firestore.FieldValue.serverTimestamp();

  await db.runTransaction(async (transaction) => {
    const userSnapshot = await transaction.get(userRef);
    const counterSnapshot = await transaction.get(counterRef);
    const userData = userSnapshot.data() || {};
    const rankingOrder =
      userData.ranking ||
      userData.rankingOrder ||
      userData.accountOrder ||
      ((counterSnapshot.data() && counterSnapshot.data().totalUsers) || 0) + 1;
    const ranking = rankingOrder;
    const displayName =
      user.displayName ||
      userData.displayName ||
      user.email ||
      "User";

    transaction.set(counterRef, {
      totalUsers: Math.max(
        rankingOrder,
        (counterSnapshot.data() && counterSnapshot.data().totalUsers) || 0,
      ),
      updatedAt: now,
    }, { merge: true });

    transaction.set(userRef, {
      email: user.email || userData.email || "",
      displayName,
      photoUrl: user.photoURL || userData.photoUrl || null,
      accountOrder: rankingOrder,
      ranking,
      rankingOrder,
      rankingPoints: userData.rankingPoints || 0,
      rankingUpdatedAt: now,
      updatedAt: now,
      createdAt: userData.createdAt || now,
    }, { merge: true });

    transaction.set(rankingRef, {
      uid: user.uid,
      displayName,
      photoUrl: user.photoURL || userData.photoUrl || null,
      ranking,
      rankingOrder,
      rankingPoints: userData.rankingPoints || 0,
      updatedAt: now,
      createdAt: userData.createdAt || now,
    }, { merge: true });
  });
});

exports.scanCV = onCall({ secrets: [groqApiKey] }, async (request) => {
  const data = request.data || {};
  const auth = await resolveCallableAuth(request);
  const uid = auth.uid;
  const db = admin.firestore();

  // 2. Lấy đầu vào từ app Flutter
  const payload = data || {};
  const jobTitle = typeof payload.jobTitle === "string" ? payload.jobTitle.trim() : "";
  const cvText = typeof payload.cvText === "string" ? payload.cvText.trim() : "";
  const fileName = sanitizeFileName(payload.fileName);
  const requestedSizeBytes = readPositiveInt(payload.sizeBytes);

  if (!jobTitle) {
    throw new HttpsError("invalid-argument", "Vui lòng nhập vị trí ứng tuyển.");
  }

  if (!cvText) {
    throw new HttpsError("invalid-argument", "Vui lòng chọn file PDF để quét CV.");
  }

  // 3. Kiểm tra số dư lượt quét (Credit)
  const userRef = db.collection("users").doc(uid);
  const userDoc = await userRef.get();

  if (!userDoc.exists) {
    throw new HttpsError("not-found", "Không tìm thấy dữ liệu người dùng.");
  }

  const userData = userDoc.data();
  let hasCredit = false;
  let useFreeCredit = false;

  if (userData.freeCvScanCount && userData.freeCvScanCount > 0) {
    hasCredit = true;
    useFreeCredit = true;
  } else if (userData.paidCvScanCredits && userData.paidCvScanCredits > 0) {
    hasCredit = true;
  }

  if (!hasCredit) {
    throw new HttpsError("resource-exhausted", "Bạn đã hết lượt quét CV. Vui lòng nâng cấp gói.");
  }

  try {
    // 4. Gọi Groq AI chấm điểm
    const apiKey = groqApiKey.value();
    if (!apiKey) {
      throw new HttpsError("failed-precondition", "Thiếu GROQ_API_KEY.");
    }

    const resolvedSizeBytes = requestedSizeBytes || 0;
    const cvContent = cvText;

    const prompt = `Bạn là chuyên gia tuyển dụng cấp cao. Hãy đánh giá CV sau đây cho vị trí "${jobTitle}".
Yêu cầu BẮT BUỘC: Chỉ trả về duy nhất 1 chuỗi JSON hợp lệ, không giải thích, không dùng markdown block.
Cấu trúc JSON bắt buộc:
{
  "overall_score": <điểm từ 1-10>,
  "summary": "tóm tắt đánh giá ngắn gọn bằng tiếng Việt",
  "strengths": ["điểm mạnh 1", "điểm mạnh 2"],
  "weaknesses": ["điểm yếu 1", "điểm yếu 2"],
  "advice": ["lời khuyên 1", "lời khuyên 2"],
  "suggested_keywords": ["từ khóa nên bổ sung 1", "từ khóa nên bổ sung 2"]
}

Nội dung CV:\n${cvContent}`;

    const aiResponse = await callGroqApi(apiKey, prompt);
    const parsedResult = normalizeScanResult(parseJsonResponse(aiResponse));

    // 5. Trừ lượt quét
    if (useFreeCredit) {
      await userRef.update({
        freeCvScanCount: admin.firestore.FieldValue.increment(-1),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    } else {
      await userRef.update({
        paidCvScanCredits: admin.firestore.FieldValue.increment(-1),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }

    // 6. Lưu lịch sử vào Firestore
    const historyRef = await userRef.collection("cv_scan_results").add({
      fileName,
      sizeBytes: resolvedSizeBytes,
      jobTitle,
      overallScore: parsedResult.overall_score,
      result: parsedResult,
      source: "text",
      uploadedAt: admin.firestore.FieldValue.serverTimestamp(),
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // 7. Trả kết quả về Flutter App
    return {
      success: true,
      historyId: historyRef.id,
      fileName,
      sizeBytes: resolvedSizeBytes,
      jobTitle,
      result: parsedResult,
    };

  } catch (error) {
    console.error("Lỗi quá trình quét CV:", error);
    if (error instanceof HttpsError) {
      throw error;
    }
    throw new functions.https.HttpsError("internal", "Lỗi AI: " + error.message);
  }
});

exports.completeTopUpPayment = onCall(async (request) => {
  const data = request.data || {};
  const auth = await resolveCallableAuth(request);
  const uid = auth.uid;
  const orderId = typeof (data && data.orderId) === "string" ? data.orderId.trim() : "";
  if (!orderId) {
    throw new HttpsError("invalid-argument", "Thiếu mã đơn hàng.");
  }

  const db = admin.firestore();
  const orderRef = db.collection("transactions").doc(orderId);
  const userRef = db.collection("users").doc(uid);

  return db.runTransaction(async (transaction) => {
    const orderSnapshot = await transaction.get(orderRef);
    if (!orderSnapshot.exists) {
      throw new HttpsError("not-found", "Không tìm thấy đơn hàng.");
    }

    const order = orderSnapshot.data() || {};
    if (order.userId !== uid) {
      throw new HttpsError("permission-denied", "Bạn không có quyền xác nhận đơn hàng này.");
    }

    const explainCredits = readPositiveInt(order.explainCredits);
    const cvScanCredits = readPositiveInt(order.cvScanCredits);
    const amount = readPositiveInt(order.amount);

    if (amount <= 0 || (explainCredits <= 0 && cvScanCredits <= 0)) {
      throw new HttpsError("failed-precondition", "Đơn hàng không hợp lệ.");
    }

    if (order.status === "completed") {
      return {
        success: true,
        completedNow: false,
        explainCredits,
        cvScanCredits,
      };
    }

    if (order.status && order.status !== "pending") {
      throw new HttpsError("failed-precondition", "Trạng thái đơn hàng không hợp lệ.");
    }

    transaction.set(userRef, {
      paidCredits: admin.firestore.FieldValue.increment(explainCredits),
      paidCvScanCredits: admin.firestore.FieldValue.increment(cvScanCredits),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    }, { merge: true });

    transaction.update(orderRef, {
      status: "completed",
      completedAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return {
      success: true,
      completedNow: true,
      explainCredits,
      cvScanCredits,
    };
  });
});

async function resolveCallableAuth(request) {
  if (request.auth && request.auth.uid) {
    return request.auth;
  }

  const data = request.data || {};
  const idToken = typeof data.idToken === "string" ? data.idToken.trim() : "";
  if (!idToken) {
    throw new HttpsError("unauthenticated", "Vui lòng đăng nhập.");
  }

  try {
    const decodedToken = await admin.auth().verifyIdToken(idToken);
    return {
      uid: decodedToken.uid,
      token: decodedToken,
    };
  } catch (error) {
    console.error("Không thể xác thực ID token dự phòng:", error);
    throw new HttpsError(
        "unauthenticated",
        "Phiên đăng nhập không hợp lệ. Vui lòng đăng nhập lại.",
    );
  }
}

async function callGroqApi(apiKey, prompt) {
  const response = await fetch("https://api.groq.com/openai/v1/chat/completions", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "Authorization": `Bearer ${apiKey}`,
    },
    body: JSON.stringify({
      model: "llama-3.3-70b-versatile",
      messages: [{ role: "user", content: prompt }],
      temperature: 0.2,
      max_tokens: 2048,
    }),
  });

  if (!response.ok) {
    const errorText = await response.text();
    throw new Error(`Groq API error ${response.status}: ${errorText}`);
  }

  const json = await response.json();
  const text = json.choices?.[0]?.message?.content || "";
  if (!text) {
    throw new Error("Groq response does not contain text.");
  }
  return text;
}

function normalizeBase64(value) {
  if (typeof value !== "string") {
    return "";
  }

  const trimmed = value.trim();
  const commaIndex = trimmed.indexOf(",");
  return commaIndex >= 0 ? trimmed.slice(commaIndex + 1).trim() : trimmed;
}

function sanitizeFileName(value) {
  if (typeof value !== "string") {
    return "CV.pdf";
  }

  const trimmed = value.trim();
  if (!trimmed) {
    return "CV.pdf";
  }

  return trimmed.replace(/[\\/:*?"<>|]/g, "_");
}

function readPositiveInt(value) {
  if (typeof value === "number" && Number.isFinite(value) && value > 0) {
    return Math.round(value);
  }

  if (typeof value === "string") {
    const parsed = Number.parseInt(value, 10);
    return Number.isFinite(parsed) && parsed > 0 ? parsed : 0;
  }

  return 0;
}

function parseJsonResponse(value) {
  const cleaned = String(value || "")
      .replace(/```json/g, "")
      .replace(/```/g, "")
      .trim();
  const firstBrace = cleaned.indexOf("{");
  const lastBrace = cleaned.lastIndexOf("}");

  if (firstBrace === -1 || lastBrace === -1 || lastBrace <= firstBrace) {
    throw new Error("Gemini response does not contain JSON.");
  }

  return JSON.parse(cleaned.slice(firstBrace, lastBrace + 1));
}

function toGeminiHttpsError(error) {
  const message = String(error && error.message ? error.message : "");
  const status = Number(error && error.status);
  const details = Array.isArray(error && error.errorDetails) ? error.errorDetails : [];
  const reason = details
      .map((detail) => detail && detail.reason)
      .find((value) => typeof value === "string") || "";

  if (reason === "API_KEY_INVALID" || message.includes("API key not valid")) {
    return new HttpsError(
        "failed-precondition",
        "Gemini API key không hợp lệ. Hãy cập nhật lại secret GEMINI_API_KEY.",
    );
  }

  if (status === 403 || message.includes("PERMISSION_DENIED")) {
    return new HttpsError(
        "failed-precondition",
        "Gemini API key chưa có quyền dùng Generative Language API.",
    );
  }

  if (status === 404 || message.includes("not found")) {
    return new HttpsError(
        "failed-precondition",
        "Model Gemini đang dùng không khả dụng. Hãy kiểm tra cấu hình model.",
    );
  }

  if (status === 429 || message.includes("RESOURCE_EXHAUSTED")) {
    return new HttpsError(
        "resource-exhausted",
        "Gemini API đã vượt hạn mức. Vui lòng thử lại sau hoặc kiểm tra billing/quota.",
    );
  }

  if (message.includes("Gemini response does not contain JSON")) {
    return new HttpsError(
        "internal",
        "Gemini trả về kết quả không đúng định dạng. Vui lòng thử scan lại.",
    );
  }

  return null;
}

function normalizeScanResult(value) {
  const result = value && typeof value === "object" ? value : {};
  const score = Number(result.overall_score ?? result.overallScore ?? result.score);

  return {
    overall_score: Number.isFinite(score) ? Math.max(1, Math.min(10, Math.round(score))) : 1,
    summary: readString(result.summary) || "Chưa có tóm tắt đánh giá.",
    strengths: readStringArray(result.strengths),
    weaknesses: readStringArray(result.weaknesses),
    advice: readStringArray(result.advice),
    suggested_keywords: readStringArray(result.suggested_keywords || result.suggestedKeywords),
  };
}

function readString(value) {
  return typeof value === "string" ? value.trim() : "";
}

function readStringArray(value) {
  if (!Array.isArray(value)) {
    return [];
  }

  return value
      .map((item) => String(item || "").trim())
      .filter((item) => item.length > 0)
      .slice(0, 8);
}


function normalizeAdaptiveQuizResult(value, jobTitle) {
  const result = value && typeof value === 'object' ? value : {};
  const cleanTitle = readString(result.title) || `AI Gap Quiz: ${jobTitle || 'Technical Skills'}`;
  const cleanDescription =
      readString(result.description) ||
      `Bộ câu hỏi tình huống thực tế bù lỗ hổng kỹ năng cho vị trí ${jobTitle || 'Lập trình viên'}.`;

  const rawQuestions = Array.isArray(result.questions) ? result.questions : [];
  const questions = [];

  for (let index = 0; index < rawQuestions.length; index++) {
    const q = rawQuestions[index];
    if (!q || typeof q !== 'object') continue;

    const rawOptions = Array.isArray(q.options) ? q.options : [];
    const options = rawOptions
        .map((opt) => String(opt || '').trim())
        .filter((opt) => opt.length > 0);

    while (options.length < 4) {
      options.push(`Phương án ${String.fromCharCode(65 + options.length)}`);
    }
    const finalOptions = options.slice(0, 4);

    let answerIndex = Number.parseInt(q.correctAnswerIndex, 10);
    if (!Number.isFinite(answerIndex) || answerIndex < 0 || answerIndex > 3) {
      answerIndex = 0;
    }

    questions.push({
      id: readString(q.id) || `adaptive_q_${index + 1}`,
      question: readString(q.question) || `Tình huống kỹ thuật số ${index + 1} cho vị trí ${jobTitle || 'IT'}:`,
      options: finalOptions,
      correctAnswerIndex: answerIndex,
      explanation:
          readString(q.explanation) ||
          'Phân tích chuyên sâu từ DevMind AI: Phương án này đáp ứng đúng nguyên lý thiết kế và tối ưu hiệu năng.',
      category: readString(q.category) || jobTitle || 'Technical',
    });
  }

  if (questions.length === 0) {
    questions.push({
      id: 'adaptive_q_1',
      question: `Trong quá trình phát triển ứng dụng cho vị trí ${jobTitle || 'Developer'}, cách tiếp cận nào tối ưu nhất khi xử lý bất đồng bộ?`,
      options: [
        'Sử dụng cơ chế luồng/stream và hủy đăng ký (dispose) khi không còn sử dụng',
        'Tạo vòng lặp vô tận kiểm tra trạng thái',
        'Bỏ qua xử lý lỗi và ngoại lệ mạng',
        'Khởi tạo lại toàn bộ state và widget tree liên tục',
      ],
      correctAnswerIndex: 0,
      explanation: 'Luôn quản lý chặt chẽ vòng đời của Stream/Future để tránh rò rỉ bộ nhớ (memory leak).',
      category: jobTitle || 'Core Engineering',
    });
  }

  return {
    title: cleanTitle,
    description: cleanDescription,
    questions,
  };
}

exports.generateAdaptiveQuizFromCv = onCall({ secrets: [groqApiKey] }, async (request) => {
  const auth = await resolveCallableAuth(request);
  const uid = auth.uid;
  const data = request.data || {};

  const jobTitle = typeof data.jobTitle === 'string' ? data.jobTitle.trim() : '';
  const weaknesses = readStringArray(data.weaknesses);
  const suggestedKeywords = readStringArray(data.suggestedKeywords);
  const questionCount = Math.max(3, Math.min(10, readPositiveInt(data.questionCount) || 5));

  if (!jobTitle) {
    throw new HttpsError('invalid-argument', 'Thiếu vị trí ứng tuyển để sinh bài test.');
  }

  const apiKey = groqApiKey.value();
  if (!apiKey) {
    throw new HttpsError('failed-precondition', 'Thiếu GROQ_API_KEY.');
  }

  const prompt = `Bạn là Lead Technical Interviewer phỏng vấn vị trí "${jobTitle}".
Ứng viên vừa quét CV và được hệ thống phát hiện các điểm yếu (weaknesses) sau:
${weaknesses.length > 0 ? weaknesses.map((w, i) => `${i + 1}. ${w}`).join('\n') : '1. Cần củng cố kiến trúc phần mềm, xử lý ngoại lệ và tối ưu hiệu năng.'}
Từ khóa gợi ý: ${suggestedKeywords.join(', ') || 'Best Practices, Design Patterns, Memory Management'}.

NHIỆM VỤ: Hãy sinh ra chính xác ${questionCount} câu hỏi trắc nghiệm kỹ thuật để kiểm tra và bù đắp các điểm yếu trên.
YÊU CẦU BẮT BUỘC:
1. Ít nhất 70% câu hỏi PHẢI là tình huống thực tế (Scenario-based) hoặc có đoạn mã ngắn (Code Snippet) để tìm bug / tối ưu.
2. 4 lựa chọn (options) phải có tính phân loại cao, các phương án sai phải phản ánh đúng lỗi sai kinh điển.
3. Phần explanation phải giải thích cặn kẽ tại sao đáp án đúng lại tối ưu và tại sao các phương án khác sai.
4. BẮT BUỘC chỉ trả về 1 chuỗi JSON hợp lệ, KHÔNG bọc trong markdown block, KHÔNG có text bên ngoài.

Cấu trúc JSON:
{
  "title": "AI Gap Quiz: ${jobTitle}",
  "description": "Bài kiểm tra tình huống thực chiến bù lỗ hổng kiến thức do DevMind AI tạo riêng.",
  "questions": [
    {
      "id": "q_1",
      "question": "Mô tả tình huống hoặc đoạn code...",
      "options": ["Phương án A", "Phương án B", "Phương án C", "Phương án D"],
      "correctAnswerIndex": 0,
      "explanation": "Giải thích chi tiết...",
      "category": "Tên chủ đề kỹ năng bị hổng"
    }
  ]
}`;

  try {
    const aiResponse = await callGroqApi(apiKey, prompt);
    const parsedJson = parseJsonResponse(aiResponse);
    const normalizedQuiz = normalizeAdaptiveQuizResult(parsedJson, jobTitle);

    const db = admin.firestore();
    const courseRef = await db.collection('technical_courses').add({
      title: normalizedQuiz.title,
      description: normalizedQuiz.description,
      category: 'ai_adaptive',
      createdBy: uid,
      questionCount: normalizedQuiz.questions.length,
      questions: normalizedQuiz.questions,
      source: 'cv_adaptive',
      jobTitle,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return {
      success: true,
      courseId: courseRef.id,
      title: normalizedQuiz.title,
      questionCount: normalizedQuiz.questions.length,
    };
  } catch (error) {
    console.error('Lỗi khi sinh câu hỏi Adaptive Quiz:', error);
    if (error instanceof HttpsError) {
      throw error;
    }
    throw new HttpsError('internal', 'Lỗi AI sinh bài kiểm tra: ' + error.message);
  }
});

exports.normalizeAdaptiveQuizResult = normalizeAdaptiveQuizResult;
