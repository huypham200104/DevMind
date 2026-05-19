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
                  padding: const EdgeInsets.fromLTRB(15, 18, 15, 28),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0F1B3B38),
                            blurRadius: 30,
                            offset: Offset(0, 18),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(18, 21, 18, 18),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Tạo tài khoản',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w800,
                                      height: 1.08,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Tham gia DevMind AI để bắt đầu luyện tập.',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: AppColors.textMuted,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const SizedBox(height: 26),
                              const AuthInputLabel(label: 'Họ và tên'),
                              AuthTextField(
                                controller: _displayNameController,
                                enabled: !authController.isLoading,
                                hintText: 'Nguyễn Văn A',
                                icon: Icons.person_outline,
                                textInputAction: TextInputAction.next,
                                validator: _validateDisplayName,
                              ),
                              const SizedBox(height: 12),
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
                              const SizedBox(height: 12),
                              const AuthInputLabel(label: 'Mật khẩu'),
                              AuthTextField(
                                controller: _passwordController,
                                enabled: !authController.isLoading,
                                hintText: 'Từ 8 đến 15 ký tự',
                                icon: Icons.lock_outline,
                                obscureText: true,
                                textInputAction: TextInputAction.next,
                                validator: _validatePassword,
                              ),
                              const SizedBox(height: 12),
                              const AuthInputLabel(label: 'Xác nhận mật khẩu'),
                              AuthTextField(
                                controller: _confirmPasswordController,
                                enabled: !authController.isLoading,
                                hintText: 'Nhập lại mật khẩu',
                                icon: Icons.lock_outline,
                                obscureText: true,
                                textInputAction: TextInputAction.done,
                                validator: _validateConfirmPassword,
                                onFieldSubmitted: (_) => _submit(),
                              ),
                              if (authController.errorMessage != null) ...[
                                const SizedBox(height: 14),
                                AuthErrorMessage(
                                  message: authController.errorMessage!,
                                ),
                              ],
                              const SizedBox(height: 20),
                              _CreateAccountButton(
                                isLoading: authController.isLoading,
                                onPressed: _submit,
                              ),
                              const SizedBox(height: 20),
                              const AuthDividerLabel(
                                label: 'Hoặc tiếp tục với',
                              ),
                              const SizedBox(height: 18),
                              GoogleAuthButton(
                                enabled: !authController.isLoading,
                                label: 'Đăng ký với Google',
                                onPressed: _submitGoogle,
                              ),
                              const SizedBox(height: 26),
                              _LoginLink(
                                enabled: !authController.isLoading,
                                onPressed: () =>
                                    context.goNamed(AppRouteNames.signIn),
                              ),
                            ],
                          ),
                        ),
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
    final signedUp = await authController.signUp(
      displayName: _displayNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (!mounted || !signedUp) {
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

  String? _validateDisplayName(String? value) {
    if ((value ?? '').trim().isEmpty) {
      return 'Nhập tên hiển thị.';
    }
    return null;
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
    if ((value ?? '').length < 8) {
      return 'Mật khẩu cần ít nhất 8 ký tự.';
    } else if ((value ?? '').length > 15) {
      return 'Mật khẩu không được vượt quá 15 ký tự.';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Mật khẩu xác nhận chưa khớp.';
    }
    return null;
  }
}

class _CreateAccountButton extends StatelessWidget {
  const _CreateAccountButton({
    required this.isLoading,
    required this.onPressed,
  });

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          textStyle: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Text('Tạo tài khoản'),
      ),
    );
  }
}

class _LoginLink extends StatelessWidget {
  const _LoginLink({required this.enabled, required this.onPressed});

  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Text(
          'Đã có tài khoản? ',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
        GestureDetector(
          onTap: enabled ? onPressed : null,
          child: Text(
            'Đăng nhập',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
