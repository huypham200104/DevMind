import 'package:flutter_test/flutter_test.dart';
import 'package:devmind_app/features/cv_scanner/domain/entities/cv_upload.dart';
import 'package:devmind_app/features/cv_scanner/domain/repositories/cv_upload_repository.dart';
import 'package:devmind_app/features/cv_scanner/presentation/controllers/cv_scanner_controller.dart';

class FakeCvRepository implements CvUploadRepository {
  bool shouldFail = false;

  @override
  Future<String> createAdaptiveQuiz({
    required String jobTitle,
    required List<String> weaknesses,
    required List<String> suggestedKeywords,
  }) async {
    if (shouldFail) {
      throw const CvScannerException('Lỗi kết nối AI server.');
    }
    return 'generated_course_456';
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
  test('generateAdaptiveQuiz sets loading state and returns courseId on success', () async {
    final repo = FakeCvRepository();
    final controller = CvScannerController(repo);
    final mockResult = CvUpload(
      id: 'upload_1',
      fileName: 'CV.pdf',
      sizeBytes: 1024,
      jobTitle: 'Flutter Developer',
      overallScore: 7,
      summary: 'Tốt',
      strengths: const ['Dart'],
      weaknesses: const ['Bloc'],
      advice: const ['Luyện thêm'],
      suggestedKeywords: const ['Bloc'],
      uploadedAt: DateTime.now(),
    );

    final courseIdFuture = controller.generateAdaptiveQuiz(mockResult);
    expect(controller.isGeneratingQuiz, isTrue);

    final courseId = await courseIdFuture;
    expect(courseId, 'generated_course_456');
    expect(controller.isGeneratingQuiz, isFalse);
    expect(controller.actionErrorMessage, isNull);
  });

  test('generateAdaptiveQuiz captures error message on failure', () async {
    final repo = FakeCvRepository()..shouldFail = true;
    final controller = CvScannerController(repo);
    final mockResult = CvUpload(
      id: 'upload_1',
      fileName: 'CV.pdf',
      sizeBytes: 1024,
      jobTitle: 'Flutter Developer',
      overallScore: 5,
      summary: '',
      strengths: const [],
      weaknesses: const [],
      advice: const [],
      suggestedKeywords: const [],
      uploadedAt: DateTime.now(),
    );

    final courseId = await controller.generateAdaptiveQuiz(mockResult);
    expect(courseId, isNull);
    expect(controller.isGeneratingQuiz, isFalse);
    expect(controller.actionErrorMessage, contains('Lỗi kết nối AI server.'));
  });
}
