const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');

const serviceAccountPath = path.join(__dirname, 'serviceAccountKey.json');
if (!fs.existsSync(serviceAccountPath)) {
  console.error('❌ ERROR: Không tìm thấy serviceAccountKey.json');
  process.exit(1);
}

admin.initializeApp({ credential: admin.credential.cert(require(serviceAccountPath)) });
const db = admin.firestore();

// Danh sách top-level collections cần xóa
const TOP_LEVEL_COLLECTIONS = [
  'badges',
  'payment_packages',
  'transactions',
  'iq_questions',
  'technical_questions',
  'rankings',
  'metadata',
];

// Subcollections của mỗi user cần xóa
const USER_SUBCOLLECTIONS = [
  'activity_log',
  'quiz_results',
  'cv_scan_results',
];

async function deleteCollection(collectionRef, batchSize = 200) {
  const query = collectionRef.limit(batchSize);
  let deleted = 0;

  while (true) {
    const snapshot = await query.get();
    if (snapshot.empty) break;

    const batch = db.batch();
    snapshot.docs.forEach((doc) => batch.delete(doc.ref));
    await batch.commit();
    deleted += snapshot.docs.length;
    process.stdout.write(`\r  Đã xóa ${deleted} docs...`);
  }

  return deleted;
}

async function deleteUsersCollection() {
  console.log('\n🗑️  Xóa collection "users" và subcollections...');
  const usersSnap = await db.collection('users').get();
  if (usersSnap.empty) {
    console.log('  (Không có user nào)');
    return;
  }

  for (const userDoc of usersSnap.docs) {
    // Xóa từng subcollection trước
    for (const sub of USER_SUBCOLLECTIONS) {
      const subRef = userDoc.ref.collection(sub);
      const count = await deleteCollection(subRef);
      if (count > 0) {
        process.stdout.write(`\n  Xóa ${count} docs trong users/${userDoc.id}/${sub}`);
      }
    }
    // Xóa document user
    await userDoc.ref.delete();
  }
  console.log(`\n  ✅ Đã xóa ${usersSnap.docs.length} user(s) và toàn bộ subcollections.`);
}

async function run() {
  console.log('🔥 BẮT ĐẦU XÓA TOÀN BỘ DỮ LIỆU FIRESTORE...\n');

  for (const colName of TOP_LEVEL_COLLECTIONS) {
    process.stdout.write(`\n🗑️  Xóa collection "${colName}"...`);
    const count = await deleteCollection(db.collection(colName));
    console.log(count > 0 ? `\n  ✅ Đã xóa ${count} docs.` : '\n  (Rỗng, bỏ qua)');
  }

  await deleteUsersCollection();

  console.log('\n\n✅ HOÀN TẤT XÓA DỮ LIỆU!');
  process.exit(0);
}

run().catch((err) => {
  console.error('❌ Lỗi khi xóa:', err);
  process.exit(1);
});
