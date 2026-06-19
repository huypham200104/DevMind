import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/router.dart';

import '../../../../core/widgets/app_dialog.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../home/presentation/widgets/home_bottom_navigation.dart';
import '../../domain/entities/cv_upload.dart';
import '../controllers/cv_scanner_controller.dart';
import '../widgets/cv_analyze_button.dart';
import '../widgets/cv_position_field.dart';
import '../widgets/cv_scan_result_card.dart';
import '../../../../core/widgets/app_header.dart';
import '../widgets/cv_upload_drop_zone.dart';
import '../widgets/recent_cv_files_section.dart';

class CvScannerScreen extends StatefulWidget {
  const CvScannerScreen({super.key});

  @override
  State<CvScannerScreen> createState() => _CvScannerScreenState();
}

class _CvScannerScreenState extends State<CvScannerScreen> {
  final _positionController = TextEditingController();
  final _scrollController = ScrollController();
  final _resultKey = GlobalKey();
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
    _scrollController.dispose();
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
              child: AppHeader(
                title: 'DevMind AI',
                onBack: _handleBack,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(36, 74, 36, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CvPositionField(controller: _positionController),
                    const SizedBox(height: 56),
                    CvUploadDropZone(
                      onTap: _handlePickPdf,
                      selectedFileName: controller.selectedFile?.fileName,
                      selectedFileSize: controller.selectedFile?.displaySize,
                      isBusy: controller.isPickingFile,
                    ),
                    if (controller.activeResult != null) ...[
                      const SizedBox(height: 36),
                      CvScanResultCard(
                        key: _resultKey,
                        result: controller.activeResult!,
                        onClose: controller.clearResult,
                      ),
                    ],
                    const SizedBox(height: 48),
                    RecentCvFilesSection(
                      files: controller.recentUploads,
                      isLoading: controller.isLoading,
                      errorMessage: controller.errorMessage,
                      onFileTap: _handleShowResult,
                    ),
                    const SizedBox(height: 36),
                    CvAnalyzeButton(
                      onPressed: controller.canScan ? _handleAnalyze : null,
                      isLoading:
                          controller.isScanning || controller.isPickingFile,
                    ),
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

  Future<void> _handlePickPdf() async {
    if (!_ensureSignedIn()) {
      return;
    }

    final controller = context.read<CvScannerController>();
    final selected = await controller.pickPdf();
    if (!mounted) {
      return;
    }

    final errorMessage = controller.actionErrorMessage;
    if (errorMessage != null) {
      _showSnackBar(errorMessage, isError: true);
      return;
    }

    if (selected && controller.selectedFile != null) {
      _showSnackBar('Đã chọn ${controller.selectedFile!.fileName}.');
    }
  }

  Future<void> _handleAnalyze() async {
    if (!_ensureSignedIn()) {
      return;
    }

    final controller = context.read<CvScannerController>();
    if (_positionController.text.trim().isEmpty) {
      _showSnackBar('Vui lòng nhập vị trí ứng tuyển.', isError: true);
      return;
    }

    if (controller.selectedFile == null) {
      final selected = await controller.pickPdf();
      if (!mounted) {
        return;
      }

      final pickErrorMessage = controller.actionErrorMessage;
      if (pickErrorMessage != null) {
        _showSnackBar(pickErrorMessage, isError: true);
        return;
      }

      if (!selected) {
        return;
      }
    }

    final scanned = await controller.scanSelectedPdf(_positionController.text);
    if (!mounted) {
      return;
    }

    final errorMessage = controller.actionErrorMessage;
    if (errorMessage != null) {
      _showSnackBar(errorMessage, isError: true);
      return;
    }

    if (scanned) {
      _showSnackBar('Đã scan CV và lưu vào lịch sử.');
      _scrollToResult();
    }
  }

  bool _ensureSignedIn() {
    if (context.read<AuthController>().currentUser != null) {
      return true;
    }

    _showSnackBar(
      'Bạn chưa đăng nhập. Vui lòng đăng nhập lại để scan CV.',
      isError: true,
    );
    context.goNamed(AppRouteNames.signIn);
    return false;
  }

  void _handleShowResult(CvUpload result) {
    context.read<CvScannerController>().showResult(result);
    _scrollToResult();
  }

  void _scrollToResult() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final resultContext = _resultKey.currentContext;
      if (!mounted || resultContext == null) {
        return;
      }

      Scrollable.ensureVisible(
        resultContext,
        alignment: 0.08,
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
      );
    });
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (isError) {
      AppDialog.showError(context, message: message);
    } else {
      AppDialog.showSuccess(context, message: message);
    }
  }
}
