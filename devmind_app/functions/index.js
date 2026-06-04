const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { GoogleGenerativeAI } = require("@google/generative-ai");

admin.initializeApp();

const GEMINI_API_KEY = process.env.GEMINI_API_KEY;
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

exports.scanCV = functions.https.onCall(async (data, context) => {
  // 1. Kiểm tra đăng nhập
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "Vui lòng đăng nhập.");
  }

  const uid = context.auth.uid;
  const db = admin.firestore();

  // 2. Lấy đầu vào từ app Flutter
  const payload = data || {};
  const jobTitle = typeof payload.jobTitle === "string" ? payload.jobTitle.trim() : "";
  const cvText = typeof payload.cvText === "string" ? payload.cvText.trim() : "";
  const pdfBase64 = normalizeBase64(payload.pdfBase64);
  const fileName = sanitizeFileName(payload.fileName);
  const requestedSizeBytes = readPositiveInt(payload.sizeBytes);

  if (!jobTitle) {
    throw new functions.https.HttpsError("invalid-argument", "Vui lòng nhập vị trí ứng tuyển.");
  }

  if (!cvText && !pdfBase64) {
    throw new functions.https.HttpsError("invalid-argument", "Vui lòng chọn file PDF để quét CV.");
  }

  if (pdfBase64 && !fileName.toLowerCase().endsWith(".pdf")) {
    throw new functions.https.HttpsError("invalid-argument", "Chỉ hỗ trợ file PDF.");
  }

  // 3. Kiểm tra số dư lượt quét (Credit)
  const userRef = db.collection("users").doc(uid);
  const userDoc = await userRef.get();

  if (!userDoc.exists) {
    throw new functions.https.HttpsError("not-found", "Không tìm thấy dữ liệu người dùng.");
  }

  const userData = userDoc.data();
  let hasCredit = false;
  let useFreeCredit = false;

  // Ưu tiên dùng lượt free trước, hết free mới dùng paid
  if (userData.freeCvScanCount && userData.freeCvScanCount > 0) {
    hasCredit = true;
    useFreeCredit = true;
  } else if (userData.paidCvScanCredits && userData.paidCvScanCredits > 0) {
    hasCredit = true;
  }

  if (!hasCredit) {
    throw new functions.https.HttpsError("resource-exhausted", "Bạn đã hết lượt quét CV. Vui lòng nâng cấp gói.");
  }

  try {
    // 4. Gọi Gemini AI chấm điểm
    if (!GEMINI_API_KEY) {
      throw new functions.https.HttpsError("failed-precondition", "Thiếu GEMINI_API_KEY.");
    }

    let pdfPart = null;
    let resolvedSizeBytes = requestedSizeBytes || 0;
    if (pdfBase64) {
      const pdfBytes = Buffer.from(pdfBase64, "base64");
      resolvedSizeBytes = pdfBytes.length;
      if (resolvedSizeBytes <= 0) {
        throw new functions.https.HttpsError("invalid-argument", "File PDF không hợp lệ.");
      }

      if (resolvedSizeBytes > MAX_CV_FILE_SIZE_BYTES) {
        throw new functions.https.HttpsError("invalid-argument", "File PDF vượt quá giới hạn 5MB.");
      }

      pdfPart = {
        inlineData: {
          data: pdfBytes.toString("base64"),
          mimeType: "application/pdf",
        },
      };
    }

    const genAI = new GoogleGenerativeAI(GEMINI_API_KEY);
    const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });
    const prompt = `Bạn là chuyên gia tuyển dụng cấp cao. Hãy đánh giá CV sau đây cho vị trí "${jobTitle}".
Yêu cầu BẮT BUỘC: Chỉ trả về duy nhất 1 chuỗi JSON hợp lệ, không giải thích, không dùng markdown block (\`\`\`json).
Cấu trúc JSON bắt buộc:
{
  "overall_score": <điểm từ 1-10>,
  "summary": "tóm tắt đánh giá ngắn gọn bằng tiếng Việt",
  "strengths": ["điểm mạnh 1", "điểm mạnh 2"],
  "weaknesses": ["điểm yếu 1", "điểm yếu 2"],
  "advice": ["lời khuyên 1", "lời khuyên 2"],
  "suggested_keywords": ["từ khóa nên bổ sung 1", "từ khóa nên bổ sung 2"]
}

${cvText ? `Nội dung CV:\n${cvText}` : "File PDF CV được đính kèm trong request này."}`;

    const contentParts = pdfPart ? [prompt, pdfPart] : [prompt];
    const result = await model.generateContent(contentParts);
    const aiResponse = result.response.text();
    const parsedResult = normalizeScanResult(parseJsonResponse(aiResponse));

    // 5. Trừ tiền (Lượt quét)
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
      source: pdfBase64 ? "pdf" : "text",
      uploadedAt: admin.firestore.FieldValue.serverTimestamp(),
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // 7. Trả kết quả về cho Flutter App
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
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }

    throw new functions.https.HttpsError("internal", "Lỗi AI. Không thể quét CV lúc này.");
  }
});

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
