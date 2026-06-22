import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/utils/theme_ext.dart';
import '../../../../core/widgets/app_placeholder_screen.dart';
import '../../../home/presentation/controllers/home_controller.dart';
import '../../../home/presentation/widgets/home_bottom_navigation.dart';
import '../../../home/presentation/widgets/home_error_banner.dart';
import '../../../../core/widgets/glassy_app_bar.dart';
import '../controllers/auth_controller.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_history_section.dart';
import '../widgets/profile_wallet_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedHistoryIndex = 0;
  String? _loadedUid;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final uid = context.watch<AuthController>().currentUser?.uid;
    if (uid == null) {
      _loadedUid = null;
      return;
    }

    if (_loadedUid == uid) {
      return;
    }

    _loadedUid = uid;
    final profileController = context.read<ProfileController>();
    Future.microtask(() => profileController.loadProfile(uid, force: true));
  }

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    final profileController = context.watch<ProfileController>();
    final user = authController.currentUser;

    if (user == null) {
      return AppPlaceholderScreen(
        title: 'Chưa đăng nhập',
        description: 'Bạn cần đăng nhập để xem hồ sơ cá nhân.',
        icon: Icons.account_circle_outlined,
        actions: [
          AppPlaceholderAction(
            label: 'Đăng nhập',
            onPressed: () => context.goNamed(AppRouteNames.signIn),
          ),
        ],
      );
    }

    final displayName = user.displayName?.trim().isNotEmpty == true
        ? user.displayName!.trim()
        : 'Huy Pham';
    final email = user.email?.trim().isNotEmpty == true
        ? user.email!.trim()
        : 'huypham@devmind.com';

    return Scaffold(
      backgroundColor: context.colors.surface,
      appBar: GlassyAppBar(
        title: 'DevMind AI',
        actions: [
          PopupMenuButton<int>(
            tooltip: 'Cài đặt',
            position: PopupMenuPosition.under,
            color: AppColors.surface,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onSelected: (action) async {
              if (action == 0) {
                final homeController = context.read<HomeController>();
                final profileController = context.read<ProfileController>();
                final appAuthController = context.read<AuthController>();
                
                homeController.clear();
                profileController.clear();
                
                await appAuthController.signOut();
                if (context.mounted) {
                  context.goNamed(AppRouteNames.welcome);
                }
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.logout, color: AppColors.danger, size: 20),
                    SizedBox(width: 10),
                    Text(
                      'Đăng xuất',
                      style: TextStyle(
                        color: AppColors.danger,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            icon: const Icon(
              Icons.settings_outlined,
              color: AppColors.primary,
              size: 30,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(AppSpacing.xxl, AppSpacing.xxl, AppSpacing.xxl, AppSpacing.xxl),
                child: Column(
                  children: [
                    ProfileHeader(
                      displayName: displayName,
                      email: email,
                      photoUrl: user.photoURL,
                      onEditProfile: () => context.pushNamed(AppRouteNames.editProfile),
                    ).animate().fade(duration: 400.ms).slideY(begin: 0.1, duration: 400.ms),
                    AppSpacing.hGapSM,
                    if (profileController.isLoading) ...[
                      AppSpacing.hGapMD,
                      const CircularProgressIndicator(),
                    ],
                    if (profileController.errorMessage != null) ...[
                      AppSpacing.hGapMD,
                      HomeErrorBanner(
                        message: profileController.errorMessage!,
                      ).animate().fade().slideY(begin: 0.1),
                    ],
                    AppSpacing.hGapSM,

                    ProfileWalletCard(
                      explainCredits:
                          profileController.profileData?.wallet.explainCredits,
                      cvScanCredits:
                          profileController.profileData?.wallet.cvScanCredits,
                      onTopUp: () => context.goNamed(AppRouteNames.wallet),
                    ).animate().fade(delay: 100.ms, duration: 400.ms).slideY(begin: 0.1, delay: 100.ms, duration: 400.ms),
                    AppSpacing.hGapXXXL,
                    ProfileHistorySection(
                      selectedIndex: _selectedHistoryIndex,
                      questions:
                          profileController.profileData?.questionHistory.reversed.take(3).toList() ??
                          const [],
                      payments:
                          profileController.profileData?.paymentHistory.reversed.take(3).toList() ??
                          const [],
                      onTabChanged: (index) {
                        setState(() {
                          _selectedHistoryIndex = index;
                        });
                      },
                    ).animate().fade(delay: 200.ms, duration: 400.ms).slideY(begin: 0.1, delay: 200.ms, duration: 400.ms),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const HomeBottomNavigation(),
    );
  }
}
