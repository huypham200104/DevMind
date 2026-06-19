import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../models/payment_order.dart';

class PaymentQrCard extends StatelessWidget {
  const PaymentQrCard({required this.order, super.key});

  final PaymentOrder order;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              order.qrUrl,
              width: 280,
              height: 280,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 280,
                  height: 280,
                  alignment: Alignment.center,
                  color: const Color(0xFFEFFBF9),
                  child: const Text('Không thể tải mã QR'),
                );
              },
            ),
          ),
          const SizedBox(height: 18),
          Text(
            formatVnd(order.amount),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }
}
