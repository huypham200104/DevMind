class RankingUser {
  const RankingUser({
    required this.uid,
    required this.displayName,
    required this.photoUrl,
    required this.points,
    required this.rankingOrder,
    required this.completedQuizCount,
    required this.firstPlaceAt,
  });

  final String uid;
  final String displayName;
  final String? photoUrl;
  final int points;
  final int rankingOrder;
  final int completedQuizCount;
  final DateTime? firstPlaceAt;

  bool get hasCompletedQuiz => completedQuizCount > 0 || points > 0;

  String get firstName {
    final normalizedName = displayName.trim();
    if (normalizedName.isEmpty) {
      return 'User';
    }

    return normalizedName.split(RegExp(r'\s+')).first;
  }
}
