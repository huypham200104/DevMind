import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/router.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/entities/home_user_profile.dart';
import '../controllers/home_controller.dart';
import '../widgets/daily_check_in_sheet.dart';
import '../widgets/home_bottom_navigation.dart';
import '../widgets/home_error_banner.dart';
import '../widgets/home_header.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/ranking_card.dart';
import '../widgets/section_header.dart';
import '../widgets/welcome_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _watchedUid;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final user = context.read<AuthController>().currentUser;
    if (user == null || _watchedUid == user.uid) {
      return;
    }

    _watchedUid = user.uid;
    final homeController = context.read<HomeController>();
    final uid = user.uid;
    final displayName = user.displayName;
    final email = user.email;
    final photoUrl = user.photoURL;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _watchedUid != uid) {
        return;
      }

      homeController.watchUser(
        uid: uid,
        displayName: displayName,
        email: email,
        photoUrl: photoUrl,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthController>().currentUser;

    if (user == null) {
      return const SizedBox.shrink();
    }

    final homeController = context.watch<HomeController>();
    final profile =
        homeController.profile ??
        HomeUserProfile.fallback(
          uid: user.uid,
          displayName: user.displayName,
          email: user.email,
          photoUrl: user.photoURL,
        );

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 20, 22, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(
                profile: profile,
                user: user,
                onCheckInTap: _openDailyCheckIn,
                checkInPoints: homeController.dailyCheckIn.points,
              ),
              const SizedBox(height: 34),
              WelcomeSection(profile: profile),
              if (homeController.errorMessage != null) ...[
                const SizedBox(height: 16),
                HomeErrorBanner(message: homeController.errorMessage!),
              ],
              const SizedBox(height: 30),
              const SectionHeader(title: 'Xếp hạng'),
              const SizedBox(height: 18),
              RankingCard(rank: profile.globalRank),
              const SizedBox(height: 26),
              SectionHeader(title: 'Dịch vụ nhanh'),
              const SizedBox(height: 14),
              QuickActionCard(
                icon: Icons.quiz_outlined,
                title: 'Ôn tập kỹ thuật',
                description:
                    'Luyện tập kiến thức Cơ bản và thuật toán nâng cao với các câu hỏi từ AI.',
                actionLabel: 'Bắt đầu luyện tập',
                onTap: () => context.goNamed(AppRouteNames.technicalQuiz),
              ),
              const SizedBox(height: 14),
              QuickActionCard(
                icon: Icons.psychology_alt_outlined,
                title: 'Kiểm tra IQ',
                description:
                    'Đánh giá tư duy logic và kỹ năng nhận thức cho các vị trí công nghệ hàng đầu.',
                actionLabel: 'Đánh giá ngay',
                onTap: () => context.goNamed(AppRouteNames.iqQuiz),
              ),
              const SizedBox(height: 14),
              QuickActionCard(
                icon: Icons.document_scanner_outlined,
                title: 'Quét CV bằng AI',
                description:
                    'Nhận phản hồi tức thì về mức độ phù hợp của CV với mô tả công việc.',
                actionLabel: 'Tải lên CV',
                onTap: () => context.goNamed(AppRouteNames.cvScanner),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const HomeBottomNavigation(),
    );
  }

  Future<void> _openDailyCheckIn() {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const DailyCheckInSheet(),
    );
  }
}
