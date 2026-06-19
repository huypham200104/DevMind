import 'package:go_router/go_router.dart';

import '../features/auth/presentation/controllers/auth_controller.dart';
import '../features/auth/presentation/screens/edit_profile_screen.dart';
import '../features/auth/presentation/screens/profile_screen.dart';
import '../features/auth/presentation/screens/sign_in_screen.dart';
import '../features/auth/presentation/screens/sign_up_screen.dart';
import '../features/auth/presentation/screens/welcome_screen.dart';
import '../features/cv_scanner/presentation/screens/cv_scanner_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';

import '../features/payment/presentation/screens/payment_screen.dart';
import '../features/technical_quiz/domain/entities/technical_course.dart';
import '../features/technical_quiz/presentation/screens/technical_course_detail_screen.dart';
import '../features/technical_quiz/presentation/screens/technical_question_screen.dart';
import '../features/technical_quiz/presentation/screens/technical_quiz_screen.dart';
import '../features/technical_quiz/presentation/screens/technical_quiz_result_screen.dart';
import '../features/technical_quiz/presentation/screens/select_questions_screen.dart';
import '../features/technical_quiz/presentation/screens/manage_custom_course_screen.dart';
import '../features/wallet/presentation/screens/wallet_screen.dart';
import '../features/ranking/presentation/screens/ranking_screen.dart';

abstract final class AppRouteNames {
  static const welcome = 'welcome';
  static const signIn = 'signIn';
  static const signUp = 'signUp';
  static const home = 'home';
  static const ranking = 'ranking';
  static const technicalQuiz = 'technicalQuiz';
  static const createTechnicalCourse = 'createTechnicalCourse';
  static const manageTechnicalCourse = 'manageTechnicalCourse';
  static const technicalCourseDetail = 'technicalCourseDetail';
  static const technicalQuestion = 'technicalQuestion';
  static const technicalQuizResult = 'technicalQuizResult';
  static const cvScanner = 'cvScanner';

  static const wallet = 'wallet';
  static const payment = 'payment';
  static const profile = 'profile';
  static const editProfile = 'editProfile';
}

abstract final class AppRoutePaths {
  static const root = '/';
  static const welcome = '/welcome';
  static const signIn = '/sign-in';
  static const signUp = '/sign-up';
  static const home = '/home';
  static const technicalQuiz = '/technical-quiz';
  static const createTechnicalCourse = '/technical-quiz/create';
  static const manageTechnicalCourse = '/technical-quiz/manage/:courseId';
  static const technicalCourseDetail = '/technical-quiz/:courseId';
  static const technicalQuestion = '/technical-quiz/:courseId/questions';
  static const technicalQuizResult = '/technical-quiz/:courseId/result';
  static const ranking = '/ranking';
  static const cvScanner = '/cv-scanner';

  static const wallet = '/wallet';
  static const payment = '/payment';
  static const profile = '/profile';
  static const editProfile = '/profile/edit';
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
        path: AppRoutePaths.createTechnicalCourse,
        name: AppRouteNames.createTechnicalCourse,
        builder: (context, state) => const SelectQuestionsScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.manageTechnicalCourse,
        name: AppRouteNames.manageTechnicalCourse,
        builder: (context, state) {
          final courseId = state.pathParameters['courseId']!;
          return ManageCustomCourseScreen(courseId: courseId);
        },
      ),
      GoRoute(
        path: AppRoutePaths.technicalQuestion,
        name: AppRouteNames.technicalQuestion,
        builder: (context, state) {
          final course = state.extra is TechnicalCourse
              ? state.extra! as TechnicalCourse
              : null;

          return TechnicalQuestionScreen(
            courseId: state.pathParameters['courseId'] ?? course?.id ?? '',
            isMine:
                state.uri.queryParameters['scope'] == 'mine' ||
                course?.isMine == true,
            initialCourse: course,
          );
        },
      ),
      GoRoute(
        path: AppRoutePaths.technicalQuizResult,
        name: AppRouteNames.technicalQuizResult,
        builder: (context, state) {
          final course = state.extra is TechnicalCourse
              ? state.extra! as TechnicalCourse
              : null;

          return TechnicalQuizResultScreen(
            courseId: state.pathParameters['courseId'] ?? course?.id ?? '',
            isMine:
                state.uri.queryParameters['scope'] == 'mine' ||
                course?.isMine == true,
            initialCourse: course,
          );
        },
      ),
      GoRoute(
        path: AppRoutePaths.technicalCourseDetail,
        name: AppRouteNames.technicalCourseDetail,
        builder: (context, state) {
          final course = state.extra is TechnicalCourse
              ? state.extra! as TechnicalCourse
              : null;

          return TechnicalCourseDetailScreen(
            courseId: state.pathParameters['courseId'] ?? course?.id ?? '',
            isMine:
                state.uri.queryParameters['scope'] == 'mine' ||
                course?.isMine == true,
            initialCourse: course,
          );
        },
      ),
      GoRoute(
        path: AppRoutePaths.cvScanner,
        name: AppRouteNames.cvScanner,
        builder: (context, state) => const CvScannerScreen(),
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
        path: AppRoutePaths.profile,
        name: AppRouteNames.profile,
        builder: (context, state) => const ProfileScreen(),
        routes: [
          GoRoute(
            path: 'edit',
            name: AppRouteNames.editProfile,
            builder: (context, state) => const EditProfileScreen(),
          ),
        ],
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
