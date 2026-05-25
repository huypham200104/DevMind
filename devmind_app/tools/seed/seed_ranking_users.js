const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');

const sampleUser = require('./data/sample_users');

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
const isDryRun = process.argv.includes('--dry-run');

function toTimestampOrNull(value) {
  if (!value) {
    return null;
  }

  return admin.firestore.Timestamp.fromDate(new Date(value));
}

function buildRankingMirror(uid, user) {
  return {
    uid,
    displayName: user.displayName || user.email || 'User',
    photoUrl: user.photoUrl || null,
    ranking: user.ranking || user.rankingOrder || user.accountOrder || 0,
    rankingOrder: user.rankingOrder || user.ranking || user.accountOrder || 0,
    rankingPoints: user.rankingPoints || 0,
    rankingFirstPlaceAt: toTimestampOrNull(user.rankingFirstPlaceAt),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  };
}

async function seedMainUser(batch) {
  const uid = sampleUser.uid;
  const updates = sampleUser.updates || {};

  batch.set(db.collection('users').doc(uid), {
    ...updates,
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  }, { merge: true });

  batch.set(
    db.collection('rankings').doc(uid),
    buildRankingMirror(uid, updates),
    { merge: true },
  );
}

async function seedRankingUsers(batch) {
  const now = admin.firestore.FieldValue.serverTimestamp();

  (sampleUser.rankingUsers || []).forEach((user) => {
    const userPayload = {
      displayName: user.displayName,
      email: user.email,
      photoUrl: user.photoUrl || null,
      accountOrder: user.accountOrder,
      ranking: user.ranking,
      rankingOrder: user.rankingOrder,
      rankingPoints: user.rankingPoints,
      rankingFirstPlaceAt: toTimestampOrNull(user.rankingFirstPlaceAt),
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

    batch.set(db.collection('users').doc(user.uid), userPayload, {
      merge: true,
    });
    batch.set(
      db.collection('rankings').doc(user.uid),
      buildRankingMirror(user.uid, user),
      { merge: true },
    );
  });
}

async function updateMetadata(batch) {
  const metadataRef = db.collection('metadata').doc('users');
  const metadataSnapshot = await metadataRef.get();
  const currentTotalUsers = metadataSnapshot.exists
    ? metadataSnapshot.get('totalUsers') || 0
    : 0;
  const sampleOrders = [
    sampleUser.updates?.accountOrder || 0,
    ...(sampleUser.rankingUsers || []).map((user) => user.accountOrder || 0),
  ];

  batch.set(metadataRef, {
    totalUsers: Math.max(currentTotalUsers, ...sampleOrders),
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  }, { merge: true });
}

async function run() {
  const rankingUsers = sampleUser.rankingUsers || [];
  console.log(`Seed ${rankingUsers.length + 1} users vào users/rankings.`);

  if (isDryRun) {
    console.log('[DRY-RUN] Main user:', {
      uid: sampleUser.uid,
      displayName: sampleUser.updates?.displayName,
      rankingPoints: sampleUser.updates?.rankingPoints,
    });
    console.log('[DRY-RUN] Ranking users:', rankingUsers.map((user) => ({
      uid: user.uid,
      displayName: user.displayName,
      ranking: user.ranking,
      rankingPoints: user.rankingPoints,
    })));
    return;
  }

  const batch = db.batch();
  await seedMainUser(batch);
  await seedRankingUsers(batch);
  await updateMetadata(batch);
  await batch.commit();

  console.log('Đã seed users ranking mẫu và collection rankings.');
}

run()
  .catch((error) => {
    console.error('Lỗi seed ranking users:', error);
    process.exitCode = 1;
  })
  .finally(() => process.exit());
