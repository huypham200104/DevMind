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
