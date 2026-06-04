import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../domain/entities/ranking_user.dart';
import '../../domain/repositories/ranking_repository.dart';

class RankingController extends ChangeNotifier {
  RankingController(this._repository);

  final RankingRepository _repository;

  StreamSubscription<List<RankingUser>>? _leaderboardSubscription;
  StreamSubscription<RankingUser?>? _currentUserSubscription;
  List<RankingUser> _leaderboard = const [];
  RankingUser? _currentUser;
  String? _activeUid;
  bool _isLoading = false;
  String? _errorMessage;

  List<RankingUser> get leaderboard => _leaderboard;
  RankingUser? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<RankedUser> get rankedUsers {
    return [
      for (var index = 0; index < _leaderboard.length; index++)
        RankedUser(rank: index + 1, user: _leaderboard[index]),
    ];
  }

  List<RankedUser> get podiumUsers => rankedUsers.take(3).toList();

  RankedUser? get currentRankedUser {
    final user = _currentUser;
    if (user == null) {
      return null;
    }

    for (final rankedUser in rankedUsers) {
      if (rankedUser.user.uid == user.uid) {
        return rankedUser;
      }
    }

    final usersBeforeCurrent = _leaderboard
        .where(
          (other) => other.uid != user.uid && _compareUsers(other, user) < 0,
        )
        .length;
    return RankedUser(rank: usersBeforeCurrent + 1, user: user);
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

  void watchRanking(String? uid) {
    if (_activeUid == uid && _leaderboardSubscription != null) {
      return;
    }

    _activeUid = uid;
    _leaderboardSubscription?.cancel();
    _currentUserSubscription?.cancel();
    _leaderboard = const [];
    _currentUser = null;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    _leaderboardSubscription = _repository.watchLeaderboard().listen(
      (users) {
        _leaderboard = users;
        _isLoading = false;
        _errorMessage = null;
        notifyListeners();
      },
      onError: (_) {
        _leaderboard = const [];
        _isLoading = false;
        _errorMessage = 'Không thể tải bảng xếp hạng từ Firebase.';
        notifyListeners();
      },
    );

    if (uid == null) {
      return;
    }

    _currentUserSubscription = _repository
        .watchUserRanking(uid)
        .listen(
          (user) {
            _currentUser = user;
            notifyListeners();
          },
          onError: (_) {
            _currentUser = null;
            notifyListeners();
          },
        );
  }

  @override
  void dispose() {
    _leaderboardSubscription?.cancel();
    _currentUserSubscription?.cancel();
    super.dispose();
  }
}

class RankedUser {
  const RankedUser({required this.rank, required this.user});

  final int rank;
  final RankingUser user;
}
