import '../entities/technical_course.dart';
import '../entities/technical_question.dart';

abstract interface class TechnicalCourseRepository {
  Stream<List<TechnicalCourse>> watchAllCourses();

  Stream<List<TechnicalCourse>> watchMyCourses(String uid);

  Future<List<TechnicalQuestion>> loadQuestionsForCourse(
    TechnicalCourse course,
  );

  Stream<int> watchExplainCredits(String uid);

  Future<bool> consumeExplainCredit(String uid);

  Future<void> deleteMyCourse(String courseId);
}
