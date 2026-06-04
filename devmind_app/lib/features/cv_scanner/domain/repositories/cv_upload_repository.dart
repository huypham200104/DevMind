import '../entities/cv_upload.dart';

abstract class CvUploadRepository {
  Stream<List<CvUpload>> watchUserUploads(String uid);

  Future<CvFileSelection?> pickPdf();

  Future<CvUpload> scanPdf({
    required CvFileSelection file,
    required String jobTitle,
  });
}
