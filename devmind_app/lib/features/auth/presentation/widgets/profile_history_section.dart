import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/profile_data.dart';

class ProfileHistorySection extends StatelessWidget {
  const ProfileHistorySection({
    required this.selectedIndex,
    required this.questions,
    required this.payments,
    required this.onTabChanged,
    super.key,
  });

  final int selectedIndex;
  final List<ProfileQuestionHistoryItem> questions;
  final List<ProfilePaymentHistoryItem> payments;
  final ValueChanged<int> onTabChanged;

  @override
  Widget build(BuildContext context) {
    final showingQuestions = selectedIndex == 0;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _HistoryTabButton(
                label: 'Lịch sử câu hỏi',
                selected: showingQuestions,
                onTap: () => onTabChanged(0),
              ),
            ),
            Expanded(
              child: _HistoryTabButton(
                label: 'Lịch sử nạp tiền',
                selected: !showingQuestions,
                onTap: () => onTabChanged(1),
              ),
            ),
          ],
        ),
        const Divider(height: 1, color: Color(0xFFE7EDF2)),
        const SizedBox(height: 16),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          child: showingQuestions
              ? _QuestionHistoryList(
                  key: const ValueKey('question-history'),
                  items: questions,
                )
              : _PaymentHistoryList(
                  key: const ValueKey('payment-history'),
                  items: payments,
                ),
        ),
      ],
    );
  }
}

class _HistoryTabButton extends StatelessWidget {
  const _HistoryTabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 22),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: selected
                    ? AppColors.primaryGradientEnd
                    : const Color(0xFF94A3B8),
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
          ),
          Container(
            height: 3,
            color: selected ? AppColors.primary : Colors.transparent,
          ),
        ],
      ),
    );
  }
}

class _QuestionHistoryList extends StatelessWidget {
  const _QuestionHistoryList({required this.items, super.key});

  final List<ProfileQuestionHistoryItem> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const _EmptyHistoryMessage(message: 'Không có lịch sử câu hỏi');
    }

    return Column(
      children: [
        for (final item in items) ...[
          ProfileQuestionHistoryCard(item: item),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _PaymentHistoryList extends StatelessWidget {
  const _PaymentHistoryList({required this.items, super.key});

  final List<ProfilePaymentHistoryItem> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const _EmptyHistoryMessage(message: 'Không có lịch sử nạp tiền');
    }

    return Column(
      children: [
        for (final item in items) ...[
          ProfilePaymentHistoryCard(item: item),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class ProfileQuestionHistoryCard extends StatelessWidget {
  const ProfileQuestionHistoryCard({required this.item, super.key});

  final ProfileQuestionHistoryItem item;

  @override
  Widget build(BuildContext context) {
    return _HistoryCard(
      leading: _QuestionThumbnail(accentColor: Color(item.accentColor)),
      title: item.title,
      subtitle: item.dateLabel,
      trailing: _ScoreBadge(
        score: item.score,
        totalQuestions: item.totalQuestions,
      ),
    );
  }
}

class ProfilePaymentHistoryCard extends StatelessWidget {
  const ProfilePaymentHistoryCard({required this.item, super.key});

  final ProfilePaymentHistoryItem item;

  @override
  Widget build(BuildContext context) {
    return _HistoryCard(
      leading: const _PaymentThumbnail(),
      title: item.title,
      subtitle: item.dateLabel,
      trailing: _PaymentBadge(
        amountLabel: item.amountLabel,
        isCompleted: item.isCompleted,
      ),
    );
  }
}

class _EmptyHistoryMessage extends StatelessWidget {
  const _EmptyHistoryMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: const Color(0xFF94A3B8),
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
        ),
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  final Widget leading;
  final String title;
  final String subtitle;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 14, 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F111827),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          leading,
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xFF0F172A),
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF8090A7),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          trailing,
        ],
      ),
    );
  }
}

class _QuestionThumbnail extends StatelessWidget {
  const _QuestionThumbnail({required this.accentColor});

  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14111827),
            blurRadius: 14,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 18,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(Icons.code, color: accentColor, size: 12),
          ),
          const SizedBox(height: 4),
          for (final width in const [32.0, 24.0, 38.0]) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: width,
                height: 4,
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PaymentThumbnail extends StatelessWidget {
  const _PaymentThumbnail();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: const Color(0xFFE8FAF8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(
        Icons.receipt_long_outlined,
        color: AppColors.primaryGradientEnd,
        size: 24,
      ),
    );
  }
}

class _ScoreBadge extends StatelessWidget {
  const _ScoreBadge({required this.score, required this.totalQuestions});

  final int score;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFE8FAF8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$score',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.primaryGradientEnd,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
            TextSpan(
              text: '/$totalQuestions',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: const Color(0xFF8090A7),
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentBadge extends StatelessWidget {
  const _PaymentBadge({required this.amountLabel, required this.isCompleted});

  final String amountLabel;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: isCompleted ? const Color(0xFFE8FAF8) : const Color(0xFFFFF1F2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        amountLabel,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: isCompleted
              ? AppColors.primaryGradientEnd
              : const Color(0xFFE11D48),
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
        ),
      ),
    );
  }
}
