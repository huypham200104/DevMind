import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../models/payment_order.dart';
import '../widgets/payment_error_view.dart';
import '../widgets/payment_header.dart';
import '../widgets/payment_info_card.dart';
import '../widgets/payment_message_scaffold.dart';
import '../widgets/payment_qr_card.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _functions = FirebaseFunctions.instance;
  final _auth = FirebaseAuth.instance;

  late PaymentOrderDraft _draft;
  Future<PaymentOrder>? _orderFuture;
  bool _initialized = false;
  bool _isCompleting = false;
  bool _isCompleted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) {
      return;
    }

    _initialized = true;
    _draft = PaymentOrderDraft.fromUri(GoRouterState.of(context).uri);
    if (_draft.isValid && _auth.currentUser != null) {
      _orderFuture = _createPendingOrder();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    if (user == null) {
      return PaymentMessageScaffold(
        title: 'Chưa đăng nhập',
        message: 'Bạn cần đăng nhập để thanh toán và nạp lượt.',
        buttonLabel: 'Đăng nhập',
        onPressed: () => context.goNamed(AppRouteNames.signIn),
      );
    }

    if (!_draft.isValid) {
      return PaymentMessageScaffold(
        title: 'Đơn hàng không hợp lệ',
        message: 'Vui lòng quay lại màn nạp lượt và chọn ít nhất một gói.',
        buttonLabel: 'Về nạp lượt',
        onPressed: () => context.goNamed(AppRouteNames.wallet),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: FutureBuilder<PaymentOrder>(
          future: _orderFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError || snapshot.data == null) {
              return PaymentErrorView(onBack: _goBackToWallet);
            }

            final order = snapshot.data!;
            return Column(
              children: [
                PaymentHeader(onBack: _goBackToWallet),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(28, 30, 28, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thanh toán VietQR',
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0,
                              ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Quét mã QR và chuyển khoản đúng nội dung để hoàn tất đơn hàng.',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                                height: 1.35,
                                letterSpacing: 0,
                              ),
                        ),
                        const SizedBox(height: 26),
                        PaymentQrCard(order: order),
                        const SizedBox(height: 22),
                        PaymentInfoCard(order: order),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(28, 12, 28, 18),
        child: SizedBox(
          height: 58,
          child: FilledButton(
            onPressed: _isCompleting || _isCompleted ? null : _completePayment,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textPrimary,
              disabledBackgroundColor: _isCompleted
                  ? const Color(0xFFE3F8F5)
                  : const Color(0xFFE2E8E7),
              disabledForegroundColor: _isCompleted
                  ? AppColors.primaryGradientEnd
                  : const Color(0xFF8CA09D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
            child: _isCompleting
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.6,
                      color: AppColors.textPrimary,
                    ),
                  )
                : Text(_isCompleted ? 'Đã nạp lượt thành công' : 'Thành công'),
          ),
        ),
      ),
    );
  }

  Future<PaymentOrder> _createPendingOrder() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw StateError('Unauthenticated');
    }

    final orderRef = _firestore.collection('transactions').doc();
    final addInfo = 'DEVMIND ${orderRef.id}';
    final order = PaymentOrder(
      id: orderRef.id,
      addInfo: addInfo,
      amount: _draft.amount,
      explainQuantity: _draft.explainQuantity,
      cvScanQuantity: _draft.cvScanQuantity,
      explainCredits: _draft.explainCredits,
      cvScanCredits: _draft.cvScanCredits,
    );

    await orderRef.set({
      'documentId': order.id,
      'userId': user.uid,
      'email': user.email,
      'packageName': order.packageName,
      'creditAmount': order.totalCredits,
      'explainQuantity': order.explainQuantity,
      'cvScanQuantity': order.cvScanQuantity,
      'explainCredits': order.explainCredits,
      'cvScanCredits': order.cvScanCredits,
      'amount': order.amount,
      'currency': 'VND',
      'addInfo': order.addInfo,
      'provider': 'vietqr',
      'bankCode': 'tpbank',
      'bankAccount': '00001074046',
      'accountName': 'PHAM NGOC HUY',
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return order;
  }

  Future<void> _completePayment() async {
    final order = await _orderFuture;
    final user = _auth.currentUser;
    if (order == null || user == null || _isCompleting || _isCompleted) {
      return;
    }

    setState(() {
      _isCompleting = true;
    });

    try {
      final callable = _functions.httpsCallable('completeTopUpPayment');
      final response = await callable.call(<String, dynamic>{
        'orderId': order.id,
      });
      final data = response.data is Map
          ? Map<String, dynamic>.from(response.data as Map)
          : const <String, dynamic>{};
      final completedNow = data['completedNow'] == true;

      if (!mounted) {
        return;
      }

      setState(() {
        _isCompleted = true;
      });

      AppDialog.showSuccess(
        context,
        message: completedNow
            ? 'Đã nạp lượt vào tài khoản.'
            : 'Đơn hàng này đã được nạp trước đó.',
      );
      context.goNamed(AppRouteNames.profile);
    } on FirebaseFunctionsException catch (error) {
      if (!mounted) {
        return;
      }

      AppDialog.showError(
        context,
        message: _paymentErrorMessage(error),
      );
    } catch (_) {
      if (!mounted) {
        return;
      }

      AppDialog.showError(
        context,
        message: 'Không thể xác nhận thanh toán. Vui lòng thử lại.',
      );
    } finally {
      if (mounted && !_isCompleted) {
        setState(() {
          _isCompleting = false;
        });
      }
    }
  }

  void _goBackToWallet() {
    context.goNamed(AppRouteNames.wallet);
  }

  String _paymentErrorMessage(FirebaseFunctionsException error) {
    if (error.code == 'not-found') {
      return 'Chưa deploy function xác nhận thanh toán hoặc không tìm thấy đơn hàng.';
    }

    return error.message?.trim().isNotEmpty == true
        ? error.message!.trim()
        : 'Không thể xác nhận thanh toán. Vui lòng thử lại.';
  }
}
