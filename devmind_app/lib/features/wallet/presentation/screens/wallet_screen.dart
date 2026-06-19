import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../models/top_up_kind.dart';
import '../../../../core/widgets/app_header.dart';
import '../widgets/top_up_option_card.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int _explainQuantity = 0;
  int _cvScanQuantity = 0;

  int get _totalQuantity => _explainQuantity + _cvScanQuantity;
  int get _totalPrice => _totalQuantity * TopUpKind.packagePriceVnd;
  bool get _hasItems => _totalQuantity > 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AppHeader(
                title: 'DevMind AI',
                onBack: _handleBack,
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.account_balance_wallet_outlined, size: 28),
                  color: AppColors.textPrimary,
                  tooltip: 'Ví lượt dùng',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(28, 34, 28, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nạp thêm lượt',
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w800,
                            height: 1.08,
                            letterSpacing: 0,
                          ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Chọn loại lượt sử dụng bạn muốn nạp vào tài khoản.',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                        height: 1.35,
                        letterSpacing: 0,
                      ),
                    ),
                    const SizedBox(height: 34),
                    TopUpOptionCard(
                      kind: TopUpKind.explain,
                      quantity: _explainQuantity,
                      onDecrease: () => _decrease(TopUpKind.explain),
                      onIncrease: () => _increase(TopUpKind.explain),
                    ),
                    const SizedBox(height: 16),
                    TopUpOptionCard(
                      kind: TopUpKind.cvScan,
                      quantity: _cvScanQuantity,
                      onDecrease: () => _decrease(TopUpKind.cvScan),
                      onIncrease: () => _increase(TopUpKind.cvScan),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(28, 12, 28, 18),
        child: SizedBox(
          height: 64,
          child: FilledButton(
            onPressed: _hasItems ? _continueToPayment : null,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textPrimary,
              disabledBackgroundColor: const Color(0xFFE2E8E7),
              disabledForegroundColor: const Color(0xFF8CA09D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
            child: Text('Tổng tiền: ${formatVnd(_totalPrice)}'),
          ),
        ),
      ),
    );
  }

  void _handleBack() {
    if (context.canPop()) {
      context.pop();
      return;
    }

    context.goNamed(AppRouteNames.profile);
  }

  void _decrease(TopUpKind kind) {
    setState(() {
      switch (kind) {
        case TopUpKind.explain:
          if (_explainQuantity > 0) {
            _explainQuantity -= 1;
          }
        case TopUpKind.cvScan:
          if (_cvScanQuantity > 0) {
            _cvScanQuantity -= 1;
          }
      }
    });
  }

  void _increase(TopUpKind kind) {
    setState(() {
      switch (kind) {
        case TopUpKind.explain:
          _explainQuantity += 1;
        case TopUpKind.cvScan:
          _cvScanQuantity += 1;
      }
    });
  }

  void _continueToPayment() {
    context.goNamed(
      AppRouteNames.payment,
      queryParameters: {
        'type': 'mixed',
        'explainQuantity': _explainQuantity.toString(),
        'cvScanQuantity': _cvScanQuantity.toString(),
        'explainCredits': TopUpKind.explain
            .totalCredits(_explainQuantity)
            .toString(),
        'cvScanCredits': TopUpKind.cvScan
            .totalCredits(_cvScanQuantity)
            .toString(),
        'amount': _totalPrice.toString(),
      },
    );
  }
}
