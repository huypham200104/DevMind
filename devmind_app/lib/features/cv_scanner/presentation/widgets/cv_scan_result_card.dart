import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/cv_upload.dart';

class CvScanResultCard extends StatelessWidget {
  const CvScanResultCard({
    super.key,
    required this.result,
    required this.onClose,
  });

  final CvUpload result;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD8EEE9)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ScoreCircle(score: result.overallScore),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.fileName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      result.jobTitle.isEmpty
                          ? result.displaySize
                          : '${result.jobTitle} • ${result.displaySize}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close),
                color: AppColors.textSecondary,
                tooltip: 'Ẩn kết quả',
              ),
            ],
          ),
          if (result.summary.isNotEmpty) ...[
            const SizedBox(height: 20),
            Text(
              result.summary,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textPrimary,
                height: 1.45,
                letterSpacing: 0,
              ),
            ),
          ],
          const SizedBox(height: 22),
          _ResultSection(
            title: 'Điểm mạnh',
            icon: Icons.check_circle_outline,
            items: result.strengths,
            emptyText: 'Gemini chưa trả về điểm mạnh cụ thể.',
          ),
          const SizedBox(height: 18),
          _ResultSection(
            title: 'Cần cải thiện',
            icon: Icons.error_outline,
            items: result.weaknesses,
            emptyText: 'Gemini chưa trả về điểm cần cải thiện.',
          ),
          const SizedBox(height: 18),
          _ResultSection(
            title: 'Lời khuyên',
            icon: Icons.lightbulb_outline,
            items: result.advice,
            emptyText: 'Gemini chưa trả về lời khuyên cụ thể.',
          ),
          if (result.suggestedKeywords.isNotEmpty) ...[
            const SizedBox(height: 20),
            Text(
              'Từ khóa nên bổ sung',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final keyword in result.suggestedKeywords)
                  _KeywordChip(keyword: keyword),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _ScoreCircle extends StatelessWidget {
  const _ScoreCircle({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      height: 76,
      decoration: const BoxDecoration(
        color: Color(0xFFE3F8F5),
        shape: BoxShape.circle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            score <= 0 ? '-' : '$score',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.primaryGradientEnd,
              fontWeight: FontWeight.w800,
              letterSpacing: 0,
            ),
          ),
          Text(
            '/10',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultSection extends StatelessWidget {
  const _ResultSection({
    required this.title,
    required this.icon,
    required this.items,
    required this.emptyText,
  });

  final String title;
  final IconData icon;
  final List<String> items;
  final String emptyText;

  @override
  Widget build(BuildContext context) {
    final visibleItems = items.isEmpty ? [emptyText] : items;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.primaryGradientEnd, size: 22),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        for (final item in visibleItems) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: SizedBox(
                  width: 6,
                  height: 6,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.primaryGradientEnd,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                    height: 1.45,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class _KeywordChip extends StatelessWidget {
  const _KeywordChip({required this.keyword});

  final String keyword;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7F6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD8EEE9)),
      ),
      child: Text(
        keyword,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.primaryGradientEnd,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
        ),
      ),
    );
  }
}
