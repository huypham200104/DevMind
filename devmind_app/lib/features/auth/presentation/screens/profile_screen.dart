import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/router.dart';
import '../../../../core/widgets/app_placeholder_screen.dart';
import '../../../home/presentation/controllers/home_controller.dart';
import '../../../home/presentation/widgets/home_bottom_navigation.dart';
import '../controllers/auth_controller.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_app_bar.dart';
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
      backgroundColor: const Color(0xFFF6F7F8),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            ProfileAppBar(
              onLogoutPressed: () async {
                // Đợi PopupMenu đóng hẳn (khoảng 300ms) để tránh lỗi "Looking up a deactivated widget's ancestor is unsafe"
                await Future.delayed(const Duration(milliseconds: 300));
                if (!context.mounted) return;
                
                context.read<HomeController>().clear();
                context.read<ProfileController>().clear();
                
                await context.read<AuthController>().signOut();
                if (context.mounted) {
                  context.goNamed(AppRouteNames.welcome);
                }
              },
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(26, 28, 26, 28),
                child: Column(
                  children: [
                    ProfileHeader(
                      displayName: displayName,
                      email: email,
                      photoUrl: user.photoURL,
                      onEditProfile: () => context.pushNamed(AppRouteNames.editProfile),
                    ),
                    const SizedBox(height: 10),
                    if (profileController.isLoading) ...[
                      const SizedBox(height: 18),
                      const CircularProgressIndicator(),
                    ],
                    if (profileController.errorMessage != null) ...[
                      const SizedBox(height: 18),
                      _ProfileErrorMessage(
                        message: profileController.errorMessage!,
                      ),
                    ],
                    const SizedBox(height: 10),

                    ProfileWalletCard(
                      explainCredits:
                          profileController.profileData?.wallet.explainCredits,
                      cvScanCredits:
                          profileController.profileData?.wallet.cvScanCredits,
                      onTopUp: () => context.goNamed(AppRouteNames.wallet),
                    ),
                    const SizedBox(height: 34),
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
                    ),
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

class _ProfileErrorMessage extends StatelessWidget {
  const _ProfileErrorMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7ED),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFED7AA)),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: const Color(0xFF9A3412),
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
        ),
      ),
    );
  }
}
