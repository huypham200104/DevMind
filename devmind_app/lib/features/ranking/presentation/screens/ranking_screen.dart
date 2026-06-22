import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/utils/theme_ext.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../home/presentation/widgets/home_bottom_navigation.dart';
import '../../../home/presentation/widgets/home_error_banner.dart';
import '../../../../core/widgets/glassy_app_bar.dart';
import '../controllers/ranking_controller.dart';
import '../widgets/current_user_rank_card.dart';
import '../widgets/ranking_podium.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  String? _watchedUid;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final uid = context.watch<AuthController>().currentUser?.uid;
    if (_watchedUid == uid) {
      return;
    }

    _watchedUid = uid;
    final controller = context.read<RankingController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _watchedUid != uid) {
        return;
      }

      controller.watchRanking(uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RankingController>();
    return Scaffold(
        backgroundColor: context.colors.surface,
        appBar: GlassyAppBar(
          title: 'Bảng Xếp Hạng',
          onBack: _handleBack,
        ),
        bottomNavigationBar: const HomeBottomNavigation(),
        body: SafeArea(
          child: Column(
            children: [
            Expanded(
              child: controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(AppSpacing.xl, 0, AppSpacing.xl, AppSpacing.xxl),
                      child: Column(
                        children: [
                          if (controller.errorMessage != null) ...[
                            HomeErrorBanner(
                              message: controller.errorMessage!,
                            ).animate().fade().slideY(begin: 0.1),
                            AppSpacing.hGapLG,
                          ],
                          RankingPodium(users: controller.podiumUsers).animate().fade(duration: 400.ms).slideY(begin: 0.1, duration: 400.ms),
                          AppSpacing.hGapXXL,
                          CurrentUserRankCard(
                            rankedUser: controller.currentRankedUser,
                          ).animate().fade(delay: 150.ms, duration: 400.ms).slideY(begin: 0.1, delay: 150.ms, duration: 400.ms),
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
}
