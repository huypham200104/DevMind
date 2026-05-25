class CvUpload {
  const CvUpload({
    required this.id,
    required this.fileName,
    required this.sizeBytes,
    required this.uploadedAt,
    required this.jobTitle,
  });

  final String id;
  final String fileName;
  final int sizeBytes;
  final DateTime? uploadedAt;
  final String jobTitle;

  String get displaySize {
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
