import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class CvUploadDropZone extends StatelessWidget {
  const CvUploadDropZone({
    super.key,
    required this.onTap,
    this.selectedFileName,
    this.selectedFileSize,
    this.isBusy = false,
  });

  final VoidCallback onTap;
  final String? selectedFileName;
  final String? selectedFileSize;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final hasSelectedFile =
        selectedFileName != null && selectedFileName!.trim().isNotEmpty;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: CustomPaint(
          painter: _DashedBorderPainter(
            color: AppColors.primaryGradientEnd,
            radius: 8,
          ),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 282),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 42),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 116,
                  height: 116,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD6F8F4),
                    shape: BoxShape.circle,
                  ),
                  child: isBusy
                      ? const Padding(
                          padding: EdgeInsets.all(34),
                          child: CircularProgressIndicator(strokeWidth: 3),
                        )
                      : Icon(
                          hasSelectedFile
                              ? Icons.picture_as_pdf_outlined
                              : Icons.upload_file_outlined,
                          color: AppColors.primaryGradientEnd,
                          size: 52,
                        ),
                ),
                const SizedBox(height: 34),
                Text(
                  hasSelectedFile ? selectedFileName! : 'Chọn file CV PDF',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                    height: 1.15,
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  hasSelectedFile
                      ? '${selectedFileSize ?? 'Không rõ dung lượng'} • Bấm để chọn file khác.'
                      : 'Bấm để chọn file PDF từ thiết bị.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                    height: 1.35,
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Hỗ trợ PDF, tối đa 5MB',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                    height: 1.35,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)),
      );

    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      const dashWidth = 10.0;
      const dashSpace = 8.0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(metric.extractPath(distance, next), paint);
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.radius != radius;
  }
}
