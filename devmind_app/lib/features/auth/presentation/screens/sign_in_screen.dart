import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_form_widgets.dart';
import '../widgets/auth_header.dart';
import '../widgets/google_auth_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                                Icons.lock_open_rounded,
                                color: AppColors.primaryGradientEnd,
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Đăng nhập',
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
                            'Dùng tài khoản email đã đăng ký để tiếp tục.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: AppColors.textSecondary,
                                  letterSpacing: 0,
                                ),
                          ),
                          const SizedBox(height: 32),

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
                            hintText: 'Nhập mật khẩu',
                            icon: Icons.lock_outline_rounded,
                            obscureText: _obscurePassword,
                            textInputAction: TextInputAction.done,
                            suffixIcon: IconButton(
                              tooltip: _obscurePassword
                                  ? 'Hiện mật khẩu'
                                  : 'Ẩn mật khẩu',
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

                          // Sign in button
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
                                  : const Text('Đăng nhập'),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const AuthDividerLabel(label: 'Hoặc tiếp tục với'),
                          const SizedBox(height: 16),
                          GoogleAuthButton(
                            enabled: !authController.isLoading,
                            label: 'Đăng nhập với Google',
                            onPressed: _submitGoogle,
                          ),
                          const SizedBox(height: 28),
                          // Register link
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              Text(
                                'Chưa có tài khoản? ',
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
                                        context.goNamed(AppRouteNames.signUp),
                                child: Text(
                                  'Tạo tài khoản',
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
    final signedIn = await authController.signIn(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (!mounted || !signedIn) return;
    context.goNamed(AppRouteNames.home);
  }

  Future<void> _submitGoogle() async {
    final signedIn = await context.read<AuthController>().signInWithGoogle();
    if (!mounted || !signedIn) return;
    context.goNamed(AppRouteNames.home);
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Nhập email.';
    if (!email.contains('@')) return 'Địa chỉ email không hợp lệ.';
    return null;
  }

  String? _validatePassword(String? value) {
    if ((value ?? '').isEmpty) return 'Nhập mật khẩu.';
    return null;
  }
}
