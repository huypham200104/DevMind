import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/glassy_app_bar.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_form_widgets.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthController>().currentUser;
    _nameController = TextEditingController(text: user?.displayName ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authController = context.read<AuthController>();
    authController.clearError();

    final success = await authController.updatePassword(
      currentPassword: _currentPasswordController.text,
      newPassword: _newPasswordController.text,
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cập nhật mật khẩu thành công!'),
          backgroundColor: AppColors.success,
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: GlassyAppBar(
        title: 'Chỉnh sửa hồ sơ',
        onBack: () {
          authController.clearError();
          context.pop();
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(28, 34, 28, 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (authController.errorMessage != null) ...[
                        AuthErrorMessage(message: authController.errorMessage!),
                        const SizedBox(height: 24),
                      ],
                      const AuthInputLabel(label: 'Tên hiển thị'),
                      AuthTextField(
                        controller: _nameController,
                        enabled: false,
                        hintText: '',
                        icon: Icons.person_outline_rounded,
                        textInputAction: TextInputAction.next,
                        validator: (_) => null,
                      ),
                      const SizedBox(height: 20),
                      const AuthInputLabel(label: 'Email'),
                      AuthTextField(
                        controller: _emailController,
                        enabled: false,
                        hintText: '',
                        icon: Icons.email_outlined,
                        textInputAction: TextInputAction.next,
                        validator: (_) => null,
                      ),
                      const SizedBox(height: 32),
                      const Divider(color: AppColors.border),
                      const SizedBox(height: 24),
                      Text(
                        'Đổi mật khẩu',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const AuthInputLabel(label: 'Mật khẩu hiện tại'),
                      AuthTextField(
                        controller: _currentPasswordController,
                        enabled: !authController.isLoading,
                        hintText: 'Nhập mật khẩu hiện tại',
                        icon: Icons.lock_outline_rounded,
                        obscureText: !_isCurrentPasswordVisible,
                        textInputAction: TextInputAction.next,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isCurrentPasswordVisible
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColors.navInactive,
                          ),
                          onPressed: () => setState(
                            () => _isCurrentPasswordVisible = !_isCurrentPasswordVisible,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập mật khẩu hiện tại';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      const AuthInputLabel(label: 'Mật khẩu mới'),
                      AuthTextField(
                        controller: _newPasswordController,
                        enabled: !authController.isLoading,
                        hintText: 'Nhập mật khẩu mới',
                        icon: Icons.lock_reset_outlined,
                        obscureText: !_isNewPasswordVisible,
                        textInputAction: TextInputAction.next,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isNewPasswordVisible
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColors.navInactive,
                          ),
                          onPressed: () => setState(
                            () => _isNewPasswordVisible = !_isNewPasswordVisible,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập mật khẩu mới';
                          }
                          if (value.length < 6) {
                            return 'Mật khẩu mới phải có ít nhất 6 ký tự';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      const AuthInputLabel(label: 'Xác nhận mật khẩu mới'),
                      AuthTextField(
                        controller: _confirmPasswordController,
                        enabled: !authController.isLoading,
                        hintText: 'Nhập lại mật khẩu mới',
                        icon: Icons.check_circle_outline_rounded,
                        obscureText: !_isConfirmPasswordVisible,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _submit(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColors.navInactive,
                          ),
                          onPressed: () => setState(
                            () => _isConfirmPasswordVisible = !_isConfirmPasswordVisible,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng xác nhận mật khẩu mới';
                          }
                          if (value != _newPasswordController.text) {
                            return 'Mật khẩu xác nhận không khớp';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      AppButton(
                        onPressed: authController.isLoading ? () {} : _submit,
                        label: authController.isLoading ? 'Đang lưu...' : 'Lưu thay đổi',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
