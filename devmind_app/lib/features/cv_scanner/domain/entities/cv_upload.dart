import 'dart:typed_data';

class CvFileSelection {
  const CvFileSelection({
    required this.fileName,
    required this.sizeBytes,
    required this.bytes,
  });

  final String fileName;
  final int sizeBytes;
  final Uint8List bytes;

  String get displaySize => CvFileSizeFormatter.format(sizeBytes);
}

class CvUpload {
  const CvUpload({
    required this.id,
    required this.fileName,
    required this.sizeBytes,
    required this.uploadedAt,
    required this.jobTitle,
    this.overallScore = 0,
    this.summary = '',
    this.strengths = const [],
    this.weaknesses = const [],
    this.advice = const [],
    this.suggestedKeywords = const [],
  });

  final String id;
  final String fileName;
  final int sizeBytes;
  final DateTime? uploadedAt;
  final String jobTitle;
  final int overallScore;
  final String summary;
  final List<String> strengths;
  final List<String> weaknesses;
  final List<String> advice;
  final List<String> suggestedKeywords;

  String get displaySize => CvFileSizeFormatter.format(sizeBytes);

  String get scoreLabel {
    if (overallScore <= 0) {
      return 'Chưa có điểm';
    }

    return '$overallScore/10';
  }
}

class CvScannerException implements Exception {
  const CvScannerException(this.message);

  final String message;

  @override
  String toString() => message;
}

abstract final class CvFileSizeFormatter {
  static String format(int sizeBytes) {
    if (sizeBytes <= 0) {
      return 'Không rõ dung lượng';
    }

    final megabytes = sizeBytes / (1024 * 1024);
    if (megabytes >= 1) {
      return '${megabytes.toStringAsFixed(1)} MB';
    }

    final kilobytes = sizeBytes / 1024;
    return '${kilobytes.toStringAsFixed(0)} KB';
  }
}
