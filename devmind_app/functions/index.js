const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { GoogleGenerativeAI } = require("@google/generative-ai");

admin.initializeApp();

const GEMINI_API_KEY = process.env.GEMINI_API_KEY;

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
  const { cvText, jobTitle } = data;
  if (!cvText || !jobTitle) {
    throw new functions.https.HttpsError("invalid-argument", "Thiếu nội dung CV hoặc vị trí ứng tuyển.");
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
    const genAI = new GoogleGenerativeAI(GEMINI_API_KEY);
    const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });
    const prompt = `Bạn là chuyên gia tuyển dụng cấp cao. Hãy đánh giá CV sau đây cho vị trí "${jobTitle}".
Yêu cầu BẮT BUỘC: Chỉ trả về duy nhất 1 chuỗi JSON hợp lệ, không giải thích, không dùng markdown block (\`\`\`json).
Cấu trúc JSON bắt buộc:
{
  "overall_score": <điểm từ 1-10>,
  "strengths": ["điểm mạnh 1", "điểm mạnh 2"],
  "weaknesses": ["điểm yếu 1", "điểm yếu 2"],
  "advice": ["lời khuyên 1", "lời khuyên 2"]
}

Nội dung CV:
${cvText}`;

    const result = await model.generateContent(prompt);
    const aiResponse = result.response.text();
    
    // Tiền xử lý chuỗi trả về để parse JSON an toàn
    const jsonString = aiResponse.replace(/```json/g, "").replace(/```/g, "").trim();
    const parsedResult = JSON.parse(jsonString);

    // 5. Trừ tiền (Lượt quét)
    if (useFreeCredit) {
      await userRef.update({ freeCvScanCount: admin.firestore.FieldValue.increment(-1) });
    } else {
      await userRef.update({ paidCvScanCredits: admin.firestore.FieldValue.increment(-1) });
    }

    // 6. Lưu lịch sử vào Firestore
    await userRef.collection("cv_scan_results").add({
      jobTitle: jobTitle,
      result: parsedResult,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // 7. Trả kết quả về cho Flutter App
    return { success: true, result: parsedResult };

  } catch (error) {
    console.error("Lỗi quá trình quét CV:", error);
    throw new functions.https.HttpsError("internal", "Lỗi AI. Không thể quét CV lúc này.");
  }
});
