import 'package:go_router/go_router.dart';

import '../features/auth/presentation/controllers/auth_controller.dart';
import '../features/auth/presentation/screens/profile_screen.dart';
import '../features/auth/presentation/screens/sign_in_screen.dart';
import '../features/auth/presentation/screens/sign_up_screen.dart';
import '../features/auth/presentation/screens/welcome_screen.dart';
import '../features/cv_scanner/presentation/screens/cv_scanner_screen.dart';
import '../features/gamification/presentation/screens/gamification_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/iq_quiz/presentation/screens/iq_quiz_screen.dart';
import '../features/payment/presentation/screens/payment_screen.dart';
import '../features/technical_quiz/presentation/screens/technical_quiz_screen.dart';
import '../features/wallet/presentation/screens/wallet_screen.dart';
import '../features/ranking/presentation/screens/ranking_screen.dart';

abstract final class AppRouteNames {
  static const welcome = 'welcome';
  static const signIn = 'signIn';
  static const signUp = 'signUp';
  static const home = 'home';
  static const ranking = 'ranking';
  static const technicalQuiz = 'technicalQuiz';
  static const cvScanner = 'cvScanner';
  static const iqQuiz = 'iqQuiz';
  static const wallet = 'wallet';
  static const payment = 'payment';
  static const gamification = 'gamification';
  static const profile = 'profile';
}

abstract final class AppRoutePaths {
  static const root = '/';
  static const welcome = '/welcome';
  static const signIn = '/sign-in';
  static const signUp = '/sign-up';
  static const home = '/home';
  static const technicalQuiz = '/technical-quiz';
  static const ranking = '/ranking';
  static const cvScanner = '/cv-scanner';
  static const iqQuiz = '/iq-quiz';
  static const wallet = '/wallet';
  static const payment = '/payment';
  static const gamification = '/gamification';
  static const profile = '/profile';
}

GoRouter createAppRouter(AuthController authController) {
  return GoRouter(
    initialLocation: AppRoutePaths.welcome,
    refreshListenable: authController,
    redirect: (context, state) => _authRedirect(authController, state),
    routes: [
      GoRoute(
        path: AppRoutePaths.root,
        redirect: (context, state) => AppRoutePaths.welcome,
      ),
      GoRoute(
        path: AppRoutePaths.welcome,
        name: AppRouteNames.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.signIn,
        name: AppRouteNames.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.signUp,
        name: AppRouteNames.signUp,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.home,
        name: AppRouteNames.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.ranking,
        name: AppRouteNames.ranking,
        builder: (context, state) => const RankingScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.technicalQuiz,
        name: AppRouteNames.technicalQuiz,
        builder: (context, state) => const TechnicalQuizScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.cvScanner,
        name: AppRouteNames.cvScanner,
        builder: (context, state) => const CvScannerScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.iqQuiz,
        name: AppRouteNames.iqQuiz,
        builder: (context, state) => const IqQuizScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.wallet,
        name: AppRouteNames.wallet,
        builder: (context, state) => const WalletScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.payment,
        name: AppRouteNames.payment,
        builder: (context, state) => const PaymentScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.gamification,
        name: AppRouteNames.gamification,
        builder: (context, state) => const GamificationScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.profile,
        name: AppRouteNames.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
}

String? _authRedirect(AuthController authController, GoRouterState state) {
  final path = state.uri.path;
  final isPublicRoute = _publicRoutePaths.contains(path);

  if (!authController.isAuthenticated && !isPublicRoute) {
    return AppRoutePaths.signIn;
  }

  if (authController.isAuthenticated && isPublicRoute) {
    return AppRoutePaths.home;
  }

  return null;
}

const _publicRoutePaths = {
  AppRoutePaths.root,
  AppRoutePaths.welcome,
  AppRoutePaths.signIn,
  AppRoutePaths.signUp,
};
