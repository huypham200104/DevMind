import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/theme_ext.dart';
import '../../../../app/theme/app_spacing.dart';

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({
    super.key,
    this.icon,
    this.svgAsset,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.onTap,
  }) : assert(icon != null || svgAsset != null);

  final IconData? icon;
  final String? svgAsset;
  final String title;
  final String description;
  final String actionLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.colors.outline,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          splashColor: context.colors.primary.withAlpha(20),
          highlightColor: context.colors.primary.withAlpha(10),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
          children: [
            // Icon badge
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: context.colors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: svgAsset != null
                    ? SvgPicture.asset(
                        svgAsset!,
                        width: 26,
                        height: 26,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      )
                    : Icon(icon, color: Colors.white, size: 26),
              ),
            ),

            AppSpacing.wGapMD,

            // Text info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.cardTitle,
                  ),
                  AppSpacing.hGapXXS,
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.cardSubtitle,
                  ),
                  AppSpacing.hGapXS,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: context.colors.primary.withAlpha(25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      actionLabel,
                      style: context.actionLabel,
                    ),
                  ),
                ],
              ),
            ),

            AppSpacing.wGapXS,

            // Arrow
            Icon(
              Icons.chevron_right_rounded,
              color: context.colors.primary,
              size: 24,
            ),
          ],
        ),
      ),
    ),
      ),
    );
  }
}
