import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/router.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../home/presentation/widgets/home_bottom_navigation.dart';
import '../../../../core/widgets/app_header.dart';
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
    const backgroundColor = Color(0xFFF7F7F7);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: backgroundColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: backgroundColor,
        bottomNavigationBar: const HomeBottomNavigation(),
        body: SafeArea(
          child: Column(
            children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AppHeader(
                title: 'Bảng Xếp Hạng',
                onBack: _handleBack,
              ),
            ),
            Expanded(
              child: controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: () async {
                        final uid = context
                            .read<AuthController>()
                            .currentUser
                            ?.uid;
                        context.read<RankingController>().watchRanking(uid);
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(22, 0, 22, 28),
                        child: Column(
                          children: [
                            if (controller.errorMessage != null) ...[
                              _RankingErrorMessage(
                                message: controller.errorMessage!,
                              ),
                              const SizedBox(height: 20),
                            ],
                            RankingPodium(users: controller.podiumUsers),
                            const SizedBox(height: 30),
                            CurrentUserRankCard(
                              rankedUser: controller.currentRankedUser,
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    ));
  }

  void _handleBack() {
    if (context.canPop()) {
      context.pop();
      return;
    }

    context.goNamed(AppRouteNames.home);
  }
}

class _RankingErrorMessage extends StatelessWidget {
  const _RankingErrorMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3F3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFF6B8B8)),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.red.shade700,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
        ),
      ),
    );
  }
}
