import 'package:flutter_test/flutter_test.dart';
import 'package:devmind_app/features/cv_scanner/domain/entities/cv_upload.dart';
import 'package:devmind_app/features/cv_scanner/domain/repositories/cv_upload_repository.dart';

class MockCvUploadRepository implements CvUploadRepository {
  @override
  Future<String> createAdaptiveQuiz({
    required String jobTitle,
    required List<String> weaknesses,
    required List<String> suggestedKeywords,
  }) async {
    if (jobTitle.isEmpty) {
      throw const CvScannerException('Vị trí ứng tuyển không được để trống.');
    }
    return 'mock_course_id_123';
  }

  @override
  Stream<List<CvUpload>> watchUserUploads(String uid) => const Stream.empty();
  @override
  Future<CvFileSelection?> pickPdf() async => null;
  @override
  Future<CvUpload> scanPdf({required CvFileSelection file, required String jobTitle}) async {
    throw UnimplementedError();
  }
}

void main() {
  test('MockCvUploadRepository returns courseId on valid input', () async {
    final repo = MockCvUploadRepository();
    final courseId = await repo.createAdaptiveQuiz(
      jobTitle: 'Flutter Dev',
      weaknesses: ['State management'],
      suggestedKeywords: ['Bloc'],
    );
    expect(courseId, 'mock_course_id_123');
  });

  test('MockCvUploadRepository throws on empty jobTitle', () async {
    final repo = MockCvUploadRepository();
    expect(
      () => repo.createAdaptiveQuiz(jobTitle: '', weaknesses: [], suggestedKeywords: []),
      throwsA(isA<CvScannerException>()),
    );
  });
}
