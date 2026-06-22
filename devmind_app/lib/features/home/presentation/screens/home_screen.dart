import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/entities/home_user_profile.dart';
import '../controllers/home_controller.dart';
import '../../../ranking/presentation/controllers/ranking_controller.dart';
import '../widgets/daily_check_in_sheet.dart';
import '../widgets/home_bottom_navigation.dart';
import '../widgets/home_error_banner.dart';
import '../../../../core/widgets/glassy_app_bar.dart';
import '../widgets/home_header_actions.dart';
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

    final user = context.watch<AuthController>().currentUser;
    if (user == null) {
      _watchedUid = null;
      return;
    }

    if (_watchedUid == user.uid) {
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
      context.read<RankingController>().watchRanking(uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthController>().currentUser;

    if (user == null) {
      return const SizedBox.shrink();
    }

    final homeController = context.watch<HomeController>();
    final rankingController = context.watch<RankingController>();
    final profile =
        homeController.profile ??
        HomeUserProfile.fallback(
          uid: user.uid,
          displayName: user.displayName,
          email: user.email,
          photoUrl: user.photoURL,
        );

    return Scaffold(
      appBar: GlassyAppBar(
        title: 'DevMind AI',
        centerTitle: false,
        titleSpacing: AppSpacing.xl,
        actions: [
          HomeHeaderActions(
            profile: profile,
            user: user,
            onCheckInTap: _handleCheckInTap,
            onAvatarTap: _handleAvatarTap,
            checkInPoints: homeController.dailyCheckIn.points,
            shouldPulseCheckIn:
                !homeController.isLoadingDailyCheckIn &&
                !homeController.dailyCheckIn.hasCheckedIn(DateTime.now()),
          ),
          AppSpacing.wGapXL,
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(AppSpacing.xl, AppSpacing.xl, AppSpacing.xl, AppSpacing.xxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WelcomeSection(profile: profile).animate().fade(duration: 400.ms).slideY(begin: 0.1, duration: 400.ms),
              if (homeController.errorMessage != null) ...[
                AppSpacing.hGapMD,
                HomeErrorBanner(message: homeController.errorMessage!).animate().fade().slideY(begin: 0.1),
              ],
              AppSpacing.hGapXXL,
              const SectionHeader(title: 'Xếp hạng').animate().fade(delay: 100.ms, duration: 400.ms).slideY(begin: 0.1, delay: 100.ms, duration: 400.ms),
              AppSpacing.hGapMD,
              RankingCard(
                rank: rankingController.currentRankedUser?.rank ?? profile.globalRank,
                points: profile.rankingPoints,
                completedQuizCount: profile.completedQuizCount,
              ).animate().fade(delay: 200.ms, duration: 400.ms).slideY(begin: 0.1, delay: 200.ms, duration: 400.ms),
              AppSpacing.hGapXXL,
              const SectionHeader(title: 'Dịch vụ nhanh').animate().fade(delay: 300.ms, duration: 400.ms).slideY(begin: 0.1, delay: 300.ms, duration: 400.ms),
              AppSpacing.hGapMD,
              QuickActionCard(
                svgAsset: 'assets/icons/lesson.svg',
                title: 'Ôn tập kỹ thuật',
                description:
                    'Luyện tập kiến thức Cơ bản và thuật toán nâng cao với các câu hỏi từ AI.',
                actionLabel: 'Bắt đầu luyện tập',
                onTap: () => context.goNamed(AppRouteNames.technicalQuiz),
              ).animate().fade(delay: 400.ms, duration: 400.ms).slideY(begin: 0.1, delay: 400.ms, duration: 400.ms),
              AppSpacing.hGapMD,
              QuickActionCard(
                svgAsset: 'assets/icons/cv_scanner.svg',
                title: 'Quét CV bằng AI',
                description:
                    'Nhận phản hồi tức thì về mức độ phù hợp của CV với mô tả công việc.',
                actionLabel: 'Tải lên CV',
                onTap: () => context.goNamed(AppRouteNames.cvScanner),
              ).animate().fade(delay: 500.ms, duration: 400.ms).slideY(begin: 0.1, delay: 500.ms, duration: 400.ms),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const HomeBottomNavigation(),
    );
  }

  Future<void> _handleCheckInTap() {
    if (context.read<AuthController>().currentUser == null) {
      context.goNamed(AppRouteNames.signIn);
      return Future.value();
    }

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const DailyCheckInSheet(),
    );
  }

  void _handleAvatarTap() {
    if (context.read<AuthController>().currentUser == null) {
      context.goNamed(AppRouteNames.signIn);
      return;
    }

    context.goNamed(AppRouteNames.profile);
  }
}
