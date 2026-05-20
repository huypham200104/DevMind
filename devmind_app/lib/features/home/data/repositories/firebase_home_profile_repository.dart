import 'package:cloud_firestore/cloud_firestore.dart';

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

    return HomeUserProfile(
      uid: uid,
      displayName: _readString(data, 'displayName') ?? '',
      email: _readString(data, 'email') ?? '',
      photoUrl: _readString(data, 'photoUrl'),
      freeExplainCount: _readInt(data, 'freeExplainCount') ?? 0,
      paidCredits: _readInt(data, 'paidCredits') ?? 0,
      globalRank: _readInt(data, 'globalRank') ?? _readInt(data, 'rank') ?? 42,
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
}
