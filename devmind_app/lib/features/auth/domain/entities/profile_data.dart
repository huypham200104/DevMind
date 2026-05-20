class ProfileData {
  const ProfileData({
    required this.wallet,
    required this.learningStats,
    required this.questionHistory,
    required this.paymentHistory,
  });

  final ProfileWalletData wallet;
  final ProfileLearningStatsData learningStats;
  final List<ProfileQuestionHistoryItem> questionHistory;
  final List<ProfilePaymentHistoryItem> paymentHistory;
}

class ProfileWalletData {
  const ProfileWalletData({
    required this.explainCredits,
    required this.cvScanCredits,
  });

  final int? explainCredits;
  final int? cvScanCredits;
}

class ProfileLearningStatsData {
  const ProfileLearningStatsData({
    required this.totalQuizzesTaken,
    required this.totalCorrectAnswers,
    required this.totalQuestionsAnswered,
    required this.currentStreak,
  });

  final int? totalQuizzesTaken;
  final int? totalCorrectAnswers;
  final int? totalQuestionsAnswered;
  final int? currentStreak;

  bool get hasAnyValue =>
      totalQuizzesTaken != null ||
      totalCorrectAnswers != null ||
      totalQuestionsAnswered != null ||
      currentStreak != null;
}

class ProfileQuestionHistoryItem {
  const ProfileQuestionHistoryItem({
    required this.title,
    required this.dateLabel,
    required this.score,
    required this.totalQuestions,
    required this.accentColor,
  });

  final String title;
  final String dateLabel;
  final int score;
  final int totalQuestions;
  final int accentColor;
}

class ProfilePaymentHistoryItem {
  const ProfilePaymentHistoryItem({
    required this.title,
    required this.dateLabel,
    required this.amountLabel,
    required this.isCompleted,
  });

  final String title;
  final String dateLabel;
  final String amountLabel;
  final bool isCompleted;
}
