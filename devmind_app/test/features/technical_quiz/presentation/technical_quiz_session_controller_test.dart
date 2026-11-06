import 'package:flutter_test/flutter_test.dart';
import 'package:devmind_app/features/technical_quiz/domain/entities/technical_course.dart';
import 'package:devmind_app/features/technical_quiz/domain/entities/technical_question.dart';
import 'package:devmind_app/features/technical_quiz/domain/repositories/technical_course_repository.dart';
import 'package:devmind_app/features/technical_quiz/presentation/controllers/technical_quiz_session_controller.dart';
import 'package:devmind_app/features/technical_quiz/presentation/controllers/technical_quiz_credits_controller.dart';
import 'package:devmind_app/features/ranking/domain/entities/ranking_user.dart';
import 'package:devmind_app/features/ranking/domain/repositories/ranking_repository.dart';

class StubQuizRepository implements TechnicalCourseRepository {
  @override
  Future<List<TechnicalQuestion>> loadQuestionsForCourse(TechnicalCourse course) async {
    return [
      const TechnicalQuestion(
        id: 'q1',
        question: 'Tình huống: Khi build Widget bị lag, nguyên nhân phổ biến là gì?',
        options: ['Rebuild lãng phí', 'Dùng const', 'Chia nhỏ widget', 'Dùng ValueNotifier'],
        correctAnswerIndex: 0,
        explanation: 'Rebuild lãng phí làm tăng CPU overhead.',
        category: 'Performance',
      ),
    ];
  }

  @override
  Stream<List<TechnicalCourse>> watchAllCourses() => const Stream.empty();
  @override
  Stream<List<TechnicalCourse>> watchMyCourses(String uid) => const Stream.empty();
  @override
  Future<void> deleteMyCourse(String courseId) async {}
  @override
  Future<void> createCustomCourse(String uid, String title, List<String> questionIds) async {}
  @override
  Future<void> removeQuestionFromCustomCourse(String courseId, String questionId) async {}
  @override
  Stream<int> watchExplainCredits(String uid) => const Stream.empty();
  @override
  Future<bool> consumeExplainCredit(String uid) async => true;
}

class StubRankingRepository implements RankingRepository {
  @override
  Future<void> recordTechnicalQuizScore({
    required String uid,
    required String courseId,
    required String courseTitle,
    required int correctAnswers,
    required int totalQuestions,
  }) async {}

  @override
  Stream<List<RankingUser>> watchLeaderboard({int limit = 100}) => const Stream.empty();
  @override
  Stream<RankingUser?> watchUserRanking(String uid) => const Stream.empty();
}

void main() {
  test('TechnicalQuizSessionController loads AI questions and manages answers', () async {
    final quizRepo = StubQuizRepository();
    final rankingRepo = StubRankingRepository();
    final creditsCtrl = TechnicalQuizCreditsController(quizRepo);
    final sessionCtrl = TechnicalQuizSessionController(quizRepo, rankingRepo, creditsCtrl);

    final aiCourse = const TechnicalCourse(
      id: 'ai_course_1',
      title: 'AI Gap Quiz: Flutter',
      description: 'Luyện tập tình huống',
      category: 'ai_adaptive',
      questionCount: 1,
      isMine: true,
    );

    await sessionCtrl.startQuiz(course: aiCourse, uid: 'user_123');

    expect(sessionCtrl.questions.length, 1);
    expect(sessionCtrl.currentQuestionIndex, 0);
    expect(sessionCtrl.currentQuestion?.id, 'q1');

    sessionCtrl.selectAnswer(0);
    expect(sessionCtrl.selectedAnswerIndex, 0);

    final submitted = sessionCtrl.submitCurrentAnswer();
    expect(submitted, isTrue);
    expect(sessionCtrl.isQuizCompleted, isTrue);
    expect(sessionCtrl.correctAnswerCount, 1);

    sessionCtrl.dispose();
  });
}
