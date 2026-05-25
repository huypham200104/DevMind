import '../entities/cv_upload.dart';

abstract class CvUploadRepository {
  Stream<List<CvUpload>> watchUserUploads(String uid);
}
