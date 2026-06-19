import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_form_widgets.dart';
import '../widgets/auth_header.dart';
import '../widgets/google_auth_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _displayNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            AuthHeader(
              onBack: () {
                if (context.canPop()) {
                  context.pop();
                  return;
                }
                context.goNamed(AppRouteNames.welcome);
              },
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Header badge
                          Center(
                            child: Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withAlpha(20),
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: AppColors.primary.withAlpha(60),
                                  width: 1.5,
                                ),
                              ),
                              child: const Icon(
                                Icons.person_add_rounded,
                                color: AppColors.primaryGradientEnd,
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Tạo tài khoản',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0,
                                ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Tham gia DevMind AI để bắt đầu luyện tập.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: AppColors.textSecondary,
                                  letterSpacing: 0,
                                ),
                          ),
                          const SizedBox(height: 32),

                          // Họ và tên
                          const AuthInputLabel(label: 'Họ và tên'),
                          AuthTextField(
                            controller: _displayNameController,
                            enabled: !authController.isLoading,
                            hintText: 'Nguyễn Văn A',
                            icon: Icons.person_outline_rounded,
                            textInputAction: TextInputAction.next,
                            validator: _validateDisplayName,
                          ),
                          const SizedBox(height: 16),

                          // Email
                          const AuthInputLabel(label: 'Địa chỉ email'),
                          AuthTextField(
                            controller: _emailController,
                            enabled: !authController.isLoading,
                            hintText: 'example@gmail.com',
                            icon: Icons.mail_outline_rounded,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: _validateEmail,
                          ),
                          const SizedBox(height: 16),

                          // Password
                          const AuthInputLabel(label: 'Mật khẩu'),
                          AuthTextField(
                            controller: _passwordController,
                            enabled: !authController.isLoading,
                            hintText: 'Từ 8 đến 15 ký tự',
                            icon: Icons.lock_outline_rounded,
                            obscureText: _obscurePassword,
                            textInputAction: TextInputAction.next,
                            suffixIcon: IconButton(
                              onPressed: () => setState(
                                () => _obscurePassword = !_obscurePassword,
                              ),
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: AppColors.textMuted,
                                size: 20,
                              ),
                            ),
                            validator: _validatePassword,
                          ),
                          const SizedBox(height: 16),

                          // Confirm password
                          const AuthInputLabel(label: 'Xác nhận mật khẩu'),
                          AuthTextField(
                            controller: _confirmPasswordController,
                            enabled: !authController.isLoading,
                            hintText: 'Nhập lại mật khẩu',
                            icon: Icons.lock_outline_rounded,
                            obscureText: _obscureConfirm,
                            textInputAction: TextInputAction.done,
                            suffixIcon: IconButton(
                              onPressed: () => setState(
                                () => _obscureConfirm = !_obscureConfirm,
                              ),
                              icon: Icon(
                                _obscureConfirm
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: AppColors.textMuted,
                                size: 20,
                              ),
                            ),
                            validator: _validateConfirmPassword,
                            onFieldSubmitted: (_) => _submit(),
                          ),

                          // Error
                          if (authController.errorMessage != null) ...[
                            const SizedBox(height: 14),
                            AuthErrorMessage(
                              message: authController.errorMessage!,
                            ),
                          ],

                          const SizedBox(height: 28),

                          // Sign up button
                          SizedBox(
                            height: 52,
                            child: FilledButton(
                              onPressed:
                                  authController.isLoading ? null : _submit,
                              style: FilledButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                textStyle: Theme.of(
                                  context,
                                ).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0,
                                ),
                              ),
                              child: authController.isLoading
                                  ? const SizedBox.square(
                                      dimension: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text('Tạo tài khoản'),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const AuthDividerLabel(label: 'Hoặc tiếp tục với'),
                          const SizedBox(height: 16),
                          GoogleAuthButton(
                            enabled: !authController.isLoading,
                            label: 'Đăng ký với Google',
                            onPressed: _submitGoogle,
                          ),
                          const SizedBox(height: 28),
                          // Login link
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              Text(
                                'Đã có tài khoản? ',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                  letterSpacing: 0,
                                ),
                              ),
                              GestureDetector(
                                onTap: authController.isLoading
                                    ? null
                                    : () =>
                                        context.goNamed(AppRouteNames.signIn),
                                child: Text(
                                  'Đăng nhập',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color: AppColors.primaryGradientEnd,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    final authController = context.read<AuthController>();
    final signedUp = await authController.signUp(
      displayName: _displayNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (!mounted || !signedUp) return;
    context.goNamed(AppRouteNames.home);
  }

  Future<void> _submitGoogle() async {
    final signedIn = await context.read<AuthController>().signInWithGoogle();
    if (!mounted || !signedIn) return;
    context.goNamed(AppRouteNames.home);
  }

  String? _validateDisplayName(String? value) {
    if ((value ?? '').trim().isEmpty) return 'Nhập tên hiển thị.';
    return null;
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Nhập email.';
    if (!email.contains('@')) return 'Địa chỉ email không hợp lệ.';
    return null;
  }

  String? _validatePassword(String? value) {
    if ((value ?? '').length < 8) return 'Mật khẩu cần ít nhất 8 ký tự.';
    if ((value ?? '').length > 15) return 'Mật khẩu không được vượt quá 15 ký tự.';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) return 'Mật khẩu xác nhận chưa khớp.';
    return null;
  }
}
