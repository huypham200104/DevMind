import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:file_picker/file_picker.dart';

import '../../domain/entities/cv_upload.dart';
import '../../domain/repositories/cv_upload_repository.dart';

class FirebaseCvUploadRepository implements CvUploadRepository {
  FirebaseCvUploadRepository({
    FirebaseFirestore? firestore,
    FirebaseFunctions? functions,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _functions = functions ?? FirebaseFunctions.instance;

  static const _maxPdfSizeBytes = 5 * 1024 * 1024;

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
      withData: true,
    );

    if (result == null || result.files.isEmpty) {
      return null;
    }

    final file = result.files.single;
    final fileName = file.name.trim().isNotEmpty ? file.name.trim() : 'CV.pdf';
    if (!fileName.toLowerCase().endsWith('.pdf')) {
      throw const CvScannerException('Chỉ hỗ trợ file PDF.');
    }

    final bytes = file.bytes;
    if (bytes == null || bytes.isEmpty) {
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
      final callable = _functions.httpsCallable('scanCV');
      final response = await callable.call(<String, dynamic>{
        'jobTitle': jobTitle,
        'fileName': file.fileName,
        'sizeBytes': file.sizeBytes,
        'pdfBase64': base64Encode(file.bytes),
      });

      return _mapCallableResult(_asStringMap(response.data), file, jobTitle);
    } on FirebaseFunctionsException catch (error) {
      throw CvScannerException(error.message ?? 'Không thể quét CV lúc này.');
    } on CvScannerException {
      rethrow;
    } catch (_) {
      throw const CvScannerException('Không thể quét CV lúc này.');
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
