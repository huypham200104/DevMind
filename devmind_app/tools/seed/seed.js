const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');

// To run this, you MUST put serviceAccountKey.json in this directory
const serviceAccountPath = path.join(__dirname, 'serviceAccountKey.json');

if (!fs.existsSync(serviceAccountPath)) {
  console.error('❌ ERROR: Không tìm thấy serviceAccountKey.json');
  console.error('Vui lòng vào Firebase Console -> Project Settings -> Service accounts -> Generate new private key');
  console.error('Lưu file vào:', serviceAccountPath);
  process.exit(1);
}

const serviceAccount = require(serviceAccountPath);

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

// Import Data Files
const badges = require('./data/badges');
const paymentPackages = require('./data/payment_packages');
const transactions = require('./data/sample_transactions');
const iqQuestions = require('./data/iq_questions');
const technicalQuestions = require('./data/technical_questions');
const sampleUser = require('./data/sample_users');

const isDryRun = process.argv.includes('--dry-run');

async function seedCollection(collectionName, dataArray) {
  console.log(`\n📦 Bắt đầu seed ${dataArray.length} items vào '${collectionName}'...`);
  
  if (isDryRun) {
    console.log(`[DRY-RUN] Sẽ upload ${dataArray.length} documents. Mẫu doc đầu tiên:`);
    console.log(dataArray[0]);
    return;
  }

  const batchSize = 100;
  for (let i = 0; i < dataArray.length; i += batchSize) {
    const chunk = dataArray.slice(i, i + batchSize);
    const batch = db.batch();
    
    chunk.forEach((item) => {
      // Use Firestore Timestamp instead of JS Date
      if (item.createdAt) {
        item.createdAt = admin.firestore.Timestamp.fromDate(new Date(item.createdAt));
      }
      const docRef = db.collection(collectionName).doc();
      batch.set(docRef, item);
    });
    
    await batch.commit();
    console.log(`Đã upload batch ${i / batchSize + 1} (${chunk.length} items)`);
  }
}

async function seedUserSubcollections() {
  console.log(`\n👤 Cập nhật user và subcollections cho user: ${sampleUser.uid}...`);
  
  if (isDryRun) {
    console.log(`[DRY-RUN] Sẽ update user ${sampleUser.uid} với data:`, sampleUser.updates);
    console.log(`[DRY-RUN] Sẽ tạo ${sampleUser.activityLogs.length} activity_log docs.`);
    console.log(`[DRY-RUN] Sẽ tạo ${sampleUser.quizResults.length} quiz_results docs.`);
    console.log(`[DRY-RUN] Sẽ tạo ${sampleUser.cvScanResults.length} cv_scan_results docs.`);
    return;
  }

  const userRef = db.collection('users').doc(sampleUser.uid);
  
  // Update main user doc
  await userRef.set({
    ...sampleUser.updates,
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  }, { merge: true });
  console.log('Đã cập nhật main user document.');

  await db.collection('rankings').doc(sampleUser.uid).set({
    uid: sampleUser.uid,
    displayName: sampleUser.updates.displayName || sampleUser.updates.email || 'User',
    photoUrl: sampleUser.updates.photoUrl || null,
    ranking: sampleUser.updates.ranking || sampleUser.updates.rankingOrder || 0,
    rankingOrder: sampleUser.updates.rankingOrder || sampleUser.updates.ranking || 0,
    rankingPoints: sampleUser.updates.rankingPoints || 0,
    rankingFirstPlaceAt: sampleUser.updates.rankingFirstPlaceAt || null,
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  }, { merge: true });
  console.log('Đã cập nhật ranking mirror cho main user.');

  // Seed Activity Logs
  const logBatch = db.batch();
  sampleUser.activityLogs.forEach((log) => {
    log.createdAt = admin.firestore.Timestamp.fromDate(new Date(log.createdAt));
    const logRef = userRef.collection('activity_log').doc(log.date);
    logBatch.set(logRef, log);
  });
  await logBatch.commit();
  console.log('Đã upload activity logs.');

  // Seed Quiz Results
  const quizBatch = db.batch();
  sampleUser.quizResults.forEach((res) => {
    res.createdAt = admin.firestore.Timestamp.fromDate(new Date(res.createdAt));
    const resRef = userRef.collection('quiz_results').doc();
    quizBatch.set(resRef, res);
  });
  await quizBatch.commit();
  console.log('Đã upload quiz results.');

  // Seed CV Scan Results
  const cvBatch = db.batch();
  sampleUser.cvScanResults.forEach((res) => {
    res.createdAt = admin.firestore.Timestamp.fromDate(new Date(res.createdAt));
    const resRef = userRef.collection('cv_scan_results').doc();
    cvBatch.set(resRef, res);
  });
  await cvBatch.commit();
  console.log('Đã upload CV scan results.');
}

function toTimestampOrNull(value) {
  if (!value) {
    return null;
  }

  return admin.firestore.Timestamp.fromDate(new Date(value));
}

async function seedRankingUsers() {
  const rankingUsers = sampleUser.rankingUsers || [];
  console.log(`\n🏆 Seed ${rankingUsers.length} user ranking mẫu...`);

  if (isDryRun) {
    console.log('[DRY-RUN] Sẽ tạo/cập nhật các users ranking mẫu:');
    console.log(rankingUsers.map((user) => ({
      uid: user.uid,
      displayName: user.displayName,
      rankingPoints: user.rankingPoints,
      ranking: user.ranking,
    })));
    return;
  }

  const batch = db.batch();
  const now = admin.firestore.FieldValue.serverTimestamp();
  const metadataRef = db.collection('metadata').doc('users');
  const metadataSnapshot = await metadataRef.get();
  const currentTotalUsers = metadataSnapshot.exists
    ? metadataSnapshot.get('totalUsers') || 0
    : 0;
  const maxSeedAccountOrder = Math.max(
    ...rankingUsers.map((user) => user.accountOrder),
    sampleUser.updates.accountOrder || 0,
  );

  rankingUsers.forEach((user) => {
    const userRef = db.collection('users').doc(user.uid);
    const rankingRef = db.collection('rankings').doc(user.uid);
    const rankingFirstPlaceAt = toTimestampOrNull(user.rankingFirstPlaceAt);

    const userPayload = {
      displayName: user.displayName,
      email: user.email,
      photoUrl: user.photoUrl || null,
      accountOrder: user.accountOrder,
      ranking: user.ranking,
      rankingOrder: user.rankingOrder,
      rankingPoints: user.rankingPoints,
      rankingFirstPlaceAt,
      totalQuizzesTaken: user.totalQuizzesTaken,
      totalCorrectAnswers: user.totalCorrectAnswers,
      totalQuestionsAnswered: user.totalQuestionsAnswered,
      technicalScore: user.technicalScore,
      iqScore: user.iqScore,
      experienceScore: user.experienceScore,
      freeExplainCount: 3,
      freeCvScanCount: 1,
      checkInPoints: 0,
      points: 0,
      createdAt: now,
      updatedAt: now,
    };

    batch.set(userRef, userPayload, { merge: true });
    batch.set(rankingRef, {
      uid: user.uid,
      displayName: user.displayName,
      photoUrl: user.photoUrl || null,
      ranking: user.ranking,
      rankingOrder: user.rankingOrder,
      rankingPoints: user.rankingPoints,
      rankingFirstPlaceAt,
      updatedAt: now,
    }, { merge: true });
  });

  batch.set(metadataRef, {
    totalUsers: Math.max(currentTotalUsers, maxSeedAccountOrder),
    updatedAt: now,
  }, { merge: true });

  await batch.commit();
  console.log('Đã seed users ranking mẫu và collection rankings.');
}

async function run() {
  try {
    if (isDryRun) {
      console.log('🧪 CHẾ ĐỘ DRY-RUN (Kiểm tra trước, không upload thật)\n');
    } else {
      console.log('🚀 Bắt đầu upload thật lên Firebase...\n');
    }

    await seedCollection('badges', badges);
    await seedCollection('payment_packages', paymentPackages);
    await seedCollection('transactions', transactions);
    await seedCollection('iq_questions', iqQuestions);
    await seedCollection('technical_questions', technicalQuestions);
    
    await seedUserSubcollections();
    await seedRankingUsers();

    console.log('\n✅ HOÀN TẤT!');
    if (!isDryRun) {
      console.log('Vui lòng kiểm tra lại trên Firebase Console.');
    }
  } catch (error) {
    console.error('❌ Lỗi:', error);
  } finally {
    process.exit(0);
  }
}

run();
