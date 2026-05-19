import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/widgets/app_placeholder_screen.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPlaceholderScreen(
      title: 'Ví lượt dùng',
      description:
          'Tính năng này quản lý lượt miễn phí, lượt nạp thêm và hạn mức dùng chung cho các tính năng AI.',
      icon: Icons.account_balance_wallet_outlined,
      actions: [
        AppPlaceholderAction(
          label: 'Nạp lượt dùng',
          onPressed: () => context.goNamed(AppRouteNames.payment),
        ),
        AppPlaceholderAction(
          label: 'Về trang chủ',
          onPressed: () => context.goNamed(AppRouteNames.home),
        ),
      ],
    );
  }
}
