import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class RankingPointsText extends StatelessWidget {
  const RankingPointsText({
    super.key,
    required this.points,
    this.fontSize = 22,
    this.color = AppColors.primaryGradientEnd,
  });

  final int points;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatPoints(points),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w800,
        letterSpacing: 0,
      ),
    );
  }

  String _formatPoints(int value) {
    return '${value.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]},')} pt';
  }
}
