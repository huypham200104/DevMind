import 'package:flutter/material.dart';

import 'payment_message_scaffold.dart';

class PaymentErrorView extends StatelessWidget {
  const PaymentErrorView({required this.onBack, super.key});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return PaymentMessageScaffold(
      title: 'Không thể tạo đơn hàng',
      message: 'Vui lòng kiểm tra kết nối và thử lại.',
      buttonLabel: 'Về nạp lượt',
      onPressed: onBack,
    );
  }
}
