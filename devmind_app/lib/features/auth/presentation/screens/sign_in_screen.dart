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
      backgroundColor: const Color(0xFFF7FAFA),
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
                  padding: const EdgeInsets.all(24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Icon(
                            Icons.login_outlined,
                            size: 56,
                            color: AppColors.primary,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Đăng nhập',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Dùng tài khoản email đã đăng ký để tiếp tục.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.textSecondary),
                          ),
                          const SizedBox(height: 28),
                          const AuthInputLabel(label: 'Địa chỉ email'),
                          AuthTextField(
                            controller: _emailController,
                            enabled: !authController.isLoading,
                            hintText: 'example123@gmail.com',
                            icon: Icons.mail_outline,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: _validateEmail,
                          ),
                          const SizedBox(height: 14),
                          const AuthInputLabel(label: 'Mật khẩu'),
                          AuthTextField(
                            controller: _passwordController,
                            enabled: !authController.isLoading,
                            hintText: 'Nhập mật khẩu',
                            icon: Icons.lock_outline,
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
                              ),
                            ),
                            validator: _validatePassword,
                            onFieldSubmitted: (_) => _submit(),
                          ),
                          if (authController.errorMessage != null) ...[
                            const SizedBox(height: 14),
                            AuthErrorMessage(
                              message: authController.errorMessage!,
                            ),
                          ],
                          const SizedBox(height: 24),
                          FilledButton(
                            onPressed: authController.isLoading
                                ? null
                                : _submit,
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
                          const SizedBox(height: 20),
                          const AuthDividerLabel(label: 'Hoặc tiếp tục với'),
                          const SizedBox(height: 18),
                          GoogleAuthButton(
                            enabled: !authController.isLoading,
                            label: 'Đăng nhập với Google',
                            onPressed: _submitGoogle,
                          ),
                          const SizedBox(height: 12),
                          OutlinedButton(
                            onPressed: authController.isLoading
                                ? null
                                : () => context.goNamed(AppRouteNames.signUp),
                            child: const Text('Tạo tài khoản'),
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

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authController = context.read<AuthController>();
    final signedIn = await authController.signIn(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (!mounted || !signedIn) {
      return;
    }

    context.goNamed(AppRouteNames.home);
  }

  Future<void> _submitGoogle() async {
    final signedIn = await context.read<AuthController>().signInWithGoogle();

    if (!mounted || !signedIn) {
      return;
    }

    context.goNamed(AppRouteNames.home);
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) {
      return 'Nhập email.';
    }
    if (!email.contains('@')) {
      return 'Địa chỉ email không hợp lệ.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if ((value ?? '').isEmpty) {
      return 'Nhập mật khẩu.';
    }
    return null;
  }
}
