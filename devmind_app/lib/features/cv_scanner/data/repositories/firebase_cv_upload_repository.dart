
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../domain/entities/cv_upload.dart';
import '../../domain/repositories/cv_upload_repository.dart';

class FirebaseCvUploadRepository implements CvUploadRepository {
  FirebaseCvUploadRepository({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    FirebaseFunctions? functions,
  }) : _auth = auth ?? FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance,
       _functions =
           functions ?? FirebaseFunctions.instanceFor(region: 'us-central1');

  static const _maxPdfSizeBytes = 5 * 1024 * 1024;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseFunctions _functions;

  @override
  Stream<List<CvUpload>> watchUserUploads(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('cv_scan_results')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(_mapUpload).toList());
  }

  @override
  Future<CvFileSelection?> pickPdf() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf'],
      allowMultiple: false,
      withData: false,
    );

    if (result == null || result.files.isEmpty) {
      return null;
    }

    final fileInfo = result.files.single;
    final fileName = fileInfo.name.trim().isNotEmpty ? fileInfo.name.trim() : 'CV.pdf';
    if (!fileName.toLowerCase().endsWith('.pdf')) {
      throw const CvScannerException('Chỉ hỗ trợ file PDF.');
    }

    if (fileInfo.path == null) {
      throw const CvScannerException('Không thể lấy đường dẫn file.');
    }

    final file = File(fileInfo.path!);
    final bytes = await file.readAsBytes();
    if (bytes.isEmpty) {
      throw const CvScannerException('Không thể đọc nội dung file PDF.');
    }

    if (bytes.length > _maxPdfSizeBytes) {
      throw const CvScannerException('File PDF vượt quá giới hạn 5MB.');
    }

    return CvFileSelection(
      fileName: fileName,
      sizeBytes: bytes.length,
      bytes: bytes,
    );
  }

  @override
  Future<CvUpload> scanPdf({
    required CvFileSelection file,
    required String jobTitle,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw const CvScannerException(
          'Bạn chưa đăng nhập. Vui lòng đăng nhập lại để scan CV.',
        );
      }

      final idToken = await user.getIdToken();
      if (idToken == null || idToken.isEmpty) {
        throw const CvScannerException(
          'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại để scan CV.',
        );
      }

      // Trích xuất text từ PDF ngay trên thiết bị
      final pdfDocument = PdfDocument(inputBytes: file.bytes);
      final extractor = PdfTextExtractor(pdfDocument);
      final cvText = extractor.extractText();
      pdfDocument.dispose();

      if (cvText.trim().isEmpty) {
        throw const CvScannerException(
          'Không thể đọc nội dung từ file PDF này. Vui lòng thử file khác.',
        );
      }

      final callable = _functions.httpsCallable('scanCV');
      final response = await callable.call<Map<String, dynamic>>({
        'jobTitle': jobTitle,
        'fileName': file.fileName,
        'sizeBytes': file.sizeBytes,
        'cvText': cvText,
        'idToken': idToken,
      });

      return _mapCallableResult(_asStringMap(response.data), file, jobTitle);
    } on FirebaseAuthException catch (error) {
      throw CvScannerException(_friendlyAuthError(error));
    } on FirebaseFunctionsException catch (error) {
      throw CvScannerException(_friendlyFunctionsError(error));
    } on CvScannerException {
      rethrow;
    } catch (_) {
      throw const CvScannerException('Không thể quét CV lúc này.');
    }
  }

  String _friendlyAuthError(FirebaseAuthException error) {
    if (error.code == 'network-request-failed') {
      return 'Không thể kết nối Firebase Auth. Kiểm tra Internet rồi thử lại.';
    }

    return 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại để scan CV.';
  }

  String _friendlyFunctionsError(FirebaseFunctionsException error) {
    switch (error.code) {
      case 'unauthenticated':
        return 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại để scan CV.';
      case 'resource-exhausted':
      case 'invalid-argument':
      case 'not-found':
      case 'failed-precondition':
        return error.message ?? 'Không thể scan CV lúc này.';
      default:
        return error.message ?? 'Không thể scan CV lúc này.';
    }
  }

  CvUpload _mapUpload(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    final result = _asStringMap(data['result']);

    return CvUpload(
      id: doc.id,
      fileName:
          _readString(data, const ['fileName', 'name', 'originalName']) ??
          'CV chưa đặt tên',
      sizeBytes: _readInt(data, const ['sizeBytes', 'fileSize', 'size']) ?? 0,
      uploadedAt: _readDateTime(data, const [
        'createdAt',
        'uploadedAt',
        'scannedAt',
      ]),
      jobTitle: _readString(data, const ['jobTitle', 'position']) ?? '',
      overallScore:
          _readInt(result, const ['overall_score', 'overallScore', 'score']) ??
          _readInt(data, const ['overallScore', 'score']) ??
          0,
      summary: _readString(result, const ['summary']) ?? '',
      strengths: _readStringList(result['strengths']),
      weaknesses: _readStringList(result['weaknesses']),
      advice: _readStringList(result['advice']),
      suggestedKeywords: _readStringList(
        result['suggested_keywords'] ?? result['suggestedKeywords'],
      ),
    );
  }

  CvUpload _mapCallableResult(
    Map<String, dynamic> data,
    CvFileSelection file,
    String fallbackJobTitle,
  ) {
    final result = _asStringMap(data['result']);

    return CvUpload(
      id: _readString(data, const ['historyId', 'id']) ?? '',
      fileName: _readString(data, const ['fileName']) ?? file.fileName,
      sizeBytes: _readInt(data, const ['sizeBytes']) ?? file.sizeBytes,
      uploadedAt: DateTime.now(),
      jobTitle: _readString(data, const ['jobTitle']) ?? fallbackJobTitle,
      overallScore:
          _readInt(result, const ['overall_score', 'overallScore', 'score']) ??
          0,
      summary: _readString(result, const ['summary']) ?? '',
      strengths: _readStringList(result['strengths']),
      weaknesses: _readStringList(result['weaknesses']),
      advice: _readStringList(result['advice']),
      suggestedKeywords: _readStringList(
        result['suggested_keywords'] ?? result['suggestedKeywords'],
      ),
    );
  }

  Map<String, dynamic> _asStringMap(Object? value) {
    if (value is Map<String, dynamic>) {
      return value;
    }

    if (value is Map) {
      return <String, dynamic>{
        for (final entry in value.entries)
          if (entry.key != null) entry.key.toString(): entry.value,
      };
    }

    return const <String, dynamic>{};
  }

  String? _readString(Map<String, dynamic> data, List<String> keys) {
    for (final key in keys) {
      final value = data[key];
      if (value is String && value.trim().isNotEmpty) {
        return value.trim();
      }
    }

    return null;
  }

  int? _readInt(Map<String, dynamic> data, List<String> keys) {
    for (final key in keys) {
      final value = data[key];
      if (value is int) {
        return value;
      }

      if (value is double) {
        return value.round();
      }

      if (value is String) {
        final parsed = int.tryParse(value);
        if (parsed != null) {
          return parsed;
        }
      }
    }

    return null;
  }

  List<String> _readStringList(Object? value) {
    if (value is! List) {
      return const [];
    }

    return value
        .map((item) => item?.toString().trim() ?? '')
        .where((item) => item.isNotEmpty)
        .toList(growable: false);
  }

  DateTime? _readDateTime(Map<String, dynamic> data, List<String> keys) {
    for (final key in keys) {
      final value = data[key];
      if (value is Timestamp) {
        return value.toDate();
      }

      if (value is DateTime) {
        return value;
      }

      if (value is String) {
        final parsed = DateTime.tryParse(value);
        if (parsed != null) {
          return parsed;
        }
      }
    }

    return null;
  }
}
