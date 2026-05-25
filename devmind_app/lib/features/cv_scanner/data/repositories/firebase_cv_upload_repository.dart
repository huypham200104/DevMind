import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/cv_upload.dart';
import '../../domain/repositories/cv_upload_repository.dart';

class FirebaseCvUploadRepository implements CvUploadRepository {
  FirebaseCvUploadRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Stream<List<CvUpload>> watchUserUploads(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('cv_uploads')
        .orderBy('uploadedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(_mapUpload).toList());
  }

  CvUpload _mapUpload(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();

    return CvUpload(
      id: doc.id,
      fileName:
          _readString(data, const ['fileName', 'name', 'originalName']) ??
          'CV chưa đặt tên',
      sizeBytes: _readInt(data, const ['sizeBytes', 'fileSize', 'size']) ?? 0,
      uploadedAt: _readDateTime(data, const ['uploadedAt', 'createdAt']),
      jobTitle: _readString(data, const ['jobTitle', 'position']) ?? '',
    );
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
