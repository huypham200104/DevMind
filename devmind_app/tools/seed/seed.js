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
  await userRef.set(sampleUser.updates, { merge: true });
  console.log('Đã cập nhật main user document.');

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
