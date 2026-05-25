import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/daily_check_in_summary.dart';
import '../../domain/entities/home_user_profile.dart';
import '../../domain/repositories/home_profile_repository.dart';

class FirebaseHomeProfileRepository implements HomeProfileRepository {
  FirebaseHomeProfileRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Stream<HomeUserProfile?> watchProfile(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((snapshot) => _mapSnapshot(snapshot, uid));
  }

  @override
  Stream<DailyCheckInSummary> watchDailyCheckIn(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map((snapshot) {
      final data = snapshot.data();
      if (!snapshot.exists || data == null) {
        return DailyCheckInSummary.empty();
      }

      final checkedInDates = _readDateSet(data, const [
        'checkedInDates',
        'checkInDates',
        'attendanceDates',
      ]);

      return DailyCheckInSummary(
        points:
            _readInt(data, 'checkInPoints') ??
            _readInt(data, 'points') ??
            _readInt(data, 'rewardPoints') ??
            0,
        currentStreak:
            _readInt(data, 'currentStreak') ??
            _calculateCurrentStreak(checkedInDates),
        totalCheckInDays:
            _readInt(data, 'totalCheckInDays') ??
            _readInt(data, 'checkInDays') ??
            checkedInDates.length,
        checkedInDates: checkedInDates,
      );
    });
  }

  @override
  Future<bool> claimDailyCheckIn(String uid) async {
    final userRef = _firestore.collection('users').doc(uid);
    final today = _today();
    final todayKey = _dateKey(today);

    return _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(userRef);
      final data = snapshot.data() ?? const <String, dynamic>{};
      final checkedInDates = _readDateSet(data, const [
        'checkedInDates',
        'checkInDates',
        'attendanceDates',
      ]);

      if (checkedInDates.contains(today)) {
        return false;
      }

      final nextDates = {...checkedInDates, today};
      final nextPoints =
          (_readInt(data, 'checkInPoints') ??
              _readInt(data, 'points') ??
              _readInt(data, 'rewardPoints') ??
              0) +
          10;
      final nextStreak = _calculateCurrentStreak(nextDates);

      transaction.set(userRef, {
        'checkInPoints': nextPoints,
        'currentStreak': nextStreak,
        'totalCheckInDays': nextDates.length,
        'checkedInDates': FieldValue.arrayUnion([todayKey]),
        'lastCheckInDate': todayKey,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      return true;
    });
  }

  HomeUserProfile? _mapSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    String uid,
  ) {
    final data = snapshot.data();
    if (!snapshot.exists || data == null) {
      return null;
    }

    final completedDays = _readInt(data, 'completedDays') ?? 12;
    final totalDays = _readInt(data, 'totalDays') ?? 20;
    final globalRank =
        _readInt(data, 'globalRank') ??
        _readInt(data, 'rank') ??
        _readInt(data, 'ranking') ??
        _readInt(data, 'rankingOrder') ??
        _readInt(data, 'accountOrder') ??
        0;

    return HomeUserProfile(
      uid: uid,
      displayName: _readString(data, 'displayName') ?? '',
      email: _readString(data, 'email') ?? '',
      photoUrl: _readString(data, 'photoUrl'),
      freeExplainCount: _readInt(data, 'freeExplainCount') ?? 0,
      paidCredits: _readInt(data, 'paidCredits') ?? 0,
      globalRank: globalRank,
      currentPathTitle:
          _readString(data, 'currentPathTitle') ??
          'Lộ trình Fullstack Engineer',
      completedDays: completedDays,
      totalDays: totalDays,
      progress:
          _readDouble(data, 'progress') ??
          _readDouble(data, 'learningProgress') ??
          _progressFromDays(completedDays, totalDays),
    );
  }

  String? _readString(Map<String, dynamic> data, String key) {
    final value = data[key];
    if (value is String && value.trim().isNotEmpty) {
      return value.trim();
    }

    return null;
  }

  int? _readInt(Map<String, dynamic> data, String key) {
    final value = data[key];
    if (value is int) {
      return value;
    }

    if (value is double) {
      return value.round();
    }

    return null;
  }

  double? _readDouble(Map<String, dynamic> data, String key) {
    final value = data[key];
    if (value is int) {
      return value.toDouble().clamp(0, 1).toDouble();
    }

    if (value is double) {
      return value.clamp(0, 1).toDouble();
    }

    return null;
  }

  double _progressFromDays(int completedDays, int totalDays) {
    if (totalDays <= 0) {
      return 0;
    }

    return (completedDays / totalDays).clamp(0, 1).toDouble();
  }

  Set<DateTime> _readDateSet(Map<String, dynamic> data, List<String> keys) {
    for (final key in keys) {
      final value = data[key];
      if (value is List) {
        return value
            .map(_readDate)
            .whereType<DateTime>()
            .map((date) => DateTime(date.year, date.month, date.day))
            .toSet();
      }
    }

    return const {};
  }

  DateTime? _readDate(Object? value) {
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

  int _calculateCurrentStreak(Set<DateTime> dates) {
    if (dates.isEmpty) {
      return 0;
    }

    var cursor = _today();
    var streak = 0;
    while (dates.contains(cursor)) {
      streak += 1;
      cursor = cursor.subtract(const Duration(days: 1));
    }

    return streak;
  }

  DateTime _today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  String _dateKey(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}
