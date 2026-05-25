import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../home/presentation/widgets/home_bottom_navigation.dart';
import '../controllers/cv_scanner_controller.dart';
import '../widgets/cv_analyze_button.dart';
import '../widgets/cv_position_field.dart';
import '../widgets/cv_scanner_header.dart';
import '../widgets/cv_upload_drop_zone.dart';
import '../widgets/recent_cv_files_section.dart';

class CvScannerScreen extends StatefulWidget {
  const CvScannerScreen({super.key});

  @override
  State<CvScannerScreen> createState() => _CvScannerScreenState();
}

class _CvScannerScreenState extends State<CvScannerScreen> {
  final _positionController = TextEditingController();
  String? _watchedUid;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final uid = context.watch<AuthController>().currentUser?.uid;
    if (_watchedUid == uid) {
      return;
    }

    _watchedUid = uid;
    final controller = context.read<CvScannerController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _watchedUid != uid) {
        return;
      }

      controller.watchUploads(uid);
    });
  }

  @override
  void dispose() {
    _positionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CvScannerController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      bottomNavigationBar: const HomeBottomNavigation(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CvScannerHeader(onBack: _handleBack),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(36, 74, 36, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CvPositionField(controller: _positionController),
                    const SizedBox(height: 96),
                    CvUploadDropZone(onTap: _showPickerPlaceholder),
                    const SizedBox(height: 64),
                    RecentCvFilesSection(
                      files: controller.recentUploads,
                      isLoading: controller.isLoading,
                      errorMessage: controller.errorMessage,
                    ),
                    const SizedBox(height: 36),
                    CvAnalyzeButton(onPressed: _showAnalyzePlaceholder),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleBack() {
    if (context.canPop()) {
      context.pop();
      return;
    }

    context.goNamed(AppRouteNames.home);
  }

  void _showPickerPlaceholder() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Chức năng chọn file CV sẽ được kết nối tiếp theo.'),
      ),
    );
  }

  void _showAnalyzePlaceholder() {
    final position = _positionController.text.trim();
    if (position.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập vị trí ứng tuyển.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Hãy chọn CV trước khi phân tích.'),
        backgroundColor: AppColors.primaryGradientEnd,
      ),
    );
  }
}
