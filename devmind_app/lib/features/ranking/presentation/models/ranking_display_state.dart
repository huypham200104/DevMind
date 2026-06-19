class RankingDisplayState {
  const RankingDisplayState({
    required this.rank,
    required this.points,
    required this.completedQuizCount,
  });

  final int rank;
  final int points;
  final int completedQuizCount;

  bool get hasCompletedQuiz => completedQuizCount > 0 || points > 0;
  bool get hasRank => hasCompletedQuiz && points > 0 && rank > 0;

  String get homeTitle {
    if (hasRank) {
      return 'Hạng:\n#$rank';
    }

    if (!hasCompletedQuiz) {
      return RankingDisplayCopy.noQuizTitle;
    }

    return 'Chưa có điểm xếp hạng';
  }

  String get cardRankLabel {
    if (hasRank) {
      return rank.toString();
    }

    return '--';
  }

  String get supportingText {
    if (!hasCompletedQuiz) {
      return RankingDisplayCopy.noQuizAction;
    }

    if (!hasRank) {
      return 'Làm thêm bài để tăng điểm.';
    }

    return 'Tiếp tục luyện tập để tăng hạng.';
  }
}

abstract final class RankingDisplayCopy {
  static const noQuizTitle = 'Bạn chưa làm bài nào';
  static const noQuizAction = 'Làm bài để tính điểm.';
}
