import '../entities/cv_upload.dart';

abstract class CvUploadRepository {
  Stream<List<CvUpload>> watchUserUploads(String uid);

  Future<CvFileSelection?> pickPdf();

  Future<CvUpload> scanPdf({
    required CvFileSelection file,
    required String jobTitle,
  });

  Future<String> createAdaptiveQuiz({
    required String jobTitle,
    required List<String> weaknesses,
    required List<String> suggestedKeywords,
  });
}
