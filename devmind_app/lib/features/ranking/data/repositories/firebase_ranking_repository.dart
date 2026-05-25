import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/ranking_user.dart';
import '../../domain/repositories/ranking_repository.dart';

class FirebaseRankingRepository implements RankingRepository {
  FirebaseRankingRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Stream<List<RankingUser>> watchLeaderboard({int limit = 100}) {
    return _firestore.collection('rankings').snapshots().map((snapshot) {
      final users = snapshot.docs.map(_mapUser).toList()..sort(_compareUsers);
      return users;
    });
  }

  @override
  Stream<RankingUser?> watchUserRanking(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map((snapshot) {
      final data = snapshot.data();
      if (!snapshot.exists || data == null) {
        return null;
      }

      return _mapUserSnapshot(uid, data);
    });
  }

  @override
  Future<void> recordTechnicalQuizScore({
    required String uid,
    required String courseId,
    required String courseTitle,
    required int correctAnswers,
    required int totalQuestions,
  }) async {
    if (courseId.trim().isEmpty || totalQuestions <= 0) {
      return;
    }

    final userRef = _firestore.collection('users').doc(uid);
    final rankingRef = _firestore.collection('rankings').doc(uid);
    final scoreRef = userRef.collection('technical_quiz_scores').doc(courseId);
    final now = FieldValue.serverTimestamp();

    await _firestore.runTransaction((transaction) async {
      final userSnapshot = await transaction.get(userRef);
      final scoreSnapshot = await transaction.get(scoreRef);
      final scoreData = scoreSnapshot.data();
      final userData = userSnapshot.data();
      final previousBest = _readInt(scoreData, 'bestCorrectAnswers') ?? 0;
      final nextBest = correctAnswers > previousBest
          ? correctAnswers
          : previousBest;
      final scoreDelta = nextBest - previousBest;

      transaction.set(scoreRef, {
        'courseId': courseId,
        'courseTitle': courseTitle,
        'lastCorrectAnswers': correctAnswers,
        'bestCorrectAnswers': nextBest,
        'totalQuestions': totalQuestions,
        'attempts': FieldValue.increment(1),
        'updatedAt': now,
        if (!scoreSnapshot.exists) 'createdAt': now,
      }, SetOptions(merge: true));

      final rankingOrder =
          _readInt(userData, 'ranking') ??
          _readInt(userData, 'rankingOrder') ??
          _readInt(userData, 'accountOrder') ??
          0;
      transaction.set(userRef, {
        'rankingPoints': FieldValue.increment(scoreDelta),
        'rankingUpdatedAt': now,
        'rankingOrder': rankingOrder,
        'ranking': rankingOrder,
        if (userData?['rankingPoints'] == null) 'rankingPointsSeededAt': now,
      }, SetOptions(merge: true));

      transaction.set(rankingRef, {
        'uid': uid,
        'displayName':
            _readString(userData ?? const {}, const [
              'displayName',
              'name',
              'email',
            ]) ??
            'User',
        'photoUrl': _readString(userData ?? const {}, const [
          'photoUrl',
          'avatarUrl',
        ]),
        'rankingPoints': FieldValue.increment(scoreDelta),
        'rankingOrder': rankingOrder,
        'ranking': rankingOrder,
        'updatedAt': now,
        if (!userSnapshot.exists) 'createdAt': now,
      }, SetOptions(merge: true));
    });
  }

  RankingUser _mapUser(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return _mapUserSnapshot(doc.id, doc.data());
  }

  RankingUser _mapUserSnapshot(String uid, Map<String, dynamic> data) {
    final displayName =
        _readString(data, const ['displayName', 'name', 'email']) ?? 'User';

    return RankingUser(
      uid: uid,
      displayName: displayName,
      photoUrl: _readString(data, const ['photoUrl', 'avatarUrl']),
      points: _readInt(data, 'rankingPoints') ?? 0,
      rankingOrder:
          _readInt(data, 'ranking') ??
          _readInt(data, 'rankingOrder') ??
          _readInt(data, 'accountOrder') ??
          0,
      firstPlaceAt: _readDateTime(data['rankingFirstPlaceAt']),
    );
  }

  int _compareUsers(RankingUser first, RankingUser second) {
    final pointsCompare = second.points.compareTo(first.points);
    if (pointsCompare != 0) {
      return pointsCompare;
    }

    final orderCompare = _normalizedOrder(
      first.rankingOrder,
    ).compareTo(_normalizedOrder(second.rankingOrder));
    if (orderCompare != 0) {
      return orderCompare;
    }

    return first.displayName.compareTo(second.displayName);
  }

  int _normalizedOrder(int order) {
    return order <= 0 ? 1 << 30 : order;
  }

  String? _readString(Map<String, dynamic> data, List<String> keys) {
    for (final key in keys) {
      final value = data[key];
      if (value is String && value.trim().isNotEmpty) {
        return value.trim();
      }
    }

    return null;
  }

  int? _readInt(Map<String, dynamic>? data, String key) {
    final value = data?[key];
    if (value is int) {
      return value;
    }

    if (value is double) {
      return value.round();
    }

    if (value is String) {
      return int.tryParse(value);
    }

    return null;
  }

  DateTime? _readDateTime(Object? value) {
    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is DateTime) {
      return value;
    }

    if (value is String) {
      return DateTime.tryParse(value);
    }

    return null;
  }
}
