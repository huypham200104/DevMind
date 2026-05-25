const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');

const serviceAccountPath = path.join(__dirname, 'serviceAccountKey.json');

if (!fs.existsSync(serviceAccountPath)) {
  console.error('ERROR: Không tìm thấy serviceAccountKey.json');
  console.error('Lưu service account key vào:', serviceAccountPath);
  process.exit(1);
}

const serviceAccount = require(serviceAccountPath);

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();

function readCreatedAt(doc) {
  const value = doc.get('createdAt');
  if (value && typeof value.toMillis === 'function') {
    return value.toMillis();
  }

  if (value instanceof Date) {
    return value.getTime();
  }

  if (typeof value === 'string') {
    const parsed = Date.parse(value);
    return Number.isNaN(parsed) ? 0 : parsed;
  }

  return 0;
}

async function run() {
  const snapshot = await db.collection('users').get();
  const users = snapshot.docs.sort((first, second) => {
    const createdAtDiff = readCreatedAt(first) - readCreatedAt(second);
    if (createdAtDiff !== 0) {
      return createdAtDiff;
    }

    return first.id.localeCompare(second.id);
  });

  const batch = db.batch();
  users.forEach((doc, index) => {
    batch.set(
      doc.ref,
      {
        accountOrder: index + 1,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      },
      { merge: true },
    );
  });

  batch.set(
    db.collection('metadata').doc('users'),
    {
      totalUsers: users.length,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    },
    { merge: true },
  );

  await batch.commit();
  console.log(`Đã backfill accountOrder cho ${users.length} users.`);
}

run()
  .catch((error) => {
    console.error('Lỗi backfill accountOrder:', error);
    process.exitCode = 1;
  })
  .finally(() => process.exit());
