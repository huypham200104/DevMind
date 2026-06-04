import '../entities/ranking_user.dart';

abstract interface class RankingRepository {
  Stream<List<RankingUser>> watchLeaderboard({int limit = 100});
  Stream<RankingUser?> watchUserRanking(String uid);

  Future<void> recordTechnicalQuizScore({
    required String uid,
    required String courseId,
    required String courseTitle,
    required int correctAnswers,
    required int totalQuestions,
  });
}
