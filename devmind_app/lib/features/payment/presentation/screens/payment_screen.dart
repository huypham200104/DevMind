import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/widgets/app_placeholder_screen.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPlaceholderScreen(
      title: 'Thanh toán',
      description:
          'Phiên bản đầu nên bắt đầu bằng thanh toán giả lập trước khi tích hợp MoMo, ZaloPay và VietQR.',
      icon: Icons.payments_outlined,
      actions: [
        AppPlaceholderAction(
          label: 'Về ví lượt dùng',
          onPressed: () => context.goNamed(AppRouteNames.wallet),
        ),
        AppPlaceholderAction(
          label: 'Về trang chủ',
          onPressed: () => context.goNamed(AppRouteNames.home),
        ),
      ],
    );
  }
}
