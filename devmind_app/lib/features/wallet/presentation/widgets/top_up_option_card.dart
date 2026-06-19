import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../models/top_up_kind.dart';

class TopUpOptionCard extends StatelessWidget {
  const TopUpOptionCard({
    required this.kind,
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
    super.key,
  });

  final TopUpKind kind;
  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  bool get _hasQuantity => quantity > 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 118),
      padding: const EdgeInsets.fromLTRB(20, 18, 16, 18),
      decoration: BoxDecoration(
        color: _hasQuantity ? const Color(0xFFEFFBF9) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _hasQuantity ? AppColors.primary : AppColors.borderStrong,
          width: _hasQuantity ? 1.4 : 1.2,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: const BoxDecoration(
              color: Color(0xFFD6F8F4),
              shape: BoxShape.circle,
            ),
            child: Icon(kind.icon, color: AppColors.primary, size: 27),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  kind.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  kind.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                    height: 1.35,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          _InlineQuantityControl(
            quantity: quantity,
            onDecrease: quantity > 0 ? onDecrease : null,
            onIncrease: onIncrease,
          ),
        ],
      ),
    );
  }
}

class _InlineQuantityControl extends StatelessWidget {
  const _InlineQuantityControl({
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
  });

  final int quantity;
  final VoidCallback? onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 104,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _QuantityIconButton(icon: Icons.remove, onPressed: onDecrease),
          SizedBox(
            width: 30,
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
          ),
          _QuantityIconButton(
            icon: Icons.add,
            onPressed: onIncrease,
            isAccent: true,
          ),
        ],
      ),
    );
  }
}

class _QuantityIconButton extends StatelessWidget {
  const _QuantityIconButton({
    required this.icon,
    required this.onPressed,
    this.isAccent = false,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final bool isAccent;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      color: AppColors.primaryGradientEnd,
      disabledColor: const Color(0xFFB7C5C2),
      style: IconButton.styleFrom(
        backgroundColor: isAccent
            ? const Color(0xFFE3F8F5)
            : Colors.transparent,
        fixedSize: const Size(34, 34),
        minimumSize: const Size(34, 34),
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
      tooltip: isAccent ? 'Tăng số lượng' : 'Giảm số lượng',
    );
  }
}
