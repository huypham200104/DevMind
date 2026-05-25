import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../features/auth/data/repositories/firebase_profile_repository.dart';
import '../features/auth/data/sources/auth_remote_data_source.dart';
import '../features/auth/domain/repositories/profile_repository.dart';
import '../features/auth/presentation/controllers/auth_controller.dart';
import '../features/auth/presentation/controllers/profile_controller.dart';
import '../features/cv_scanner/data/repositories/firebase_cv_upload_repository.dart';
import '../features/cv_scanner/domain/repositories/cv_upload_repository.dart';
import '../features/cv_scanner/presentation/controllers/cv_scanner_controller.dart';
import '../features/home/data/repositories/firebase_home_profile_repository.dart';
import '../features/home/domain/repositories/home_profile_repository.dart';
import '../features/home/presentation/controllers/home_controller.dart';
import '../features/technical_quiz/data/repositories/firebase_technical_course_repository.dart';
import '../features/technical_quiz/domain/repositories/technical_course_repository.dart';
import '../features/technical_quiz/presentation/controllers/technical_quiz_controller.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRemoteDataSource>(create: (_) => AuthRemoteDataSource()),
        ChangeNotifierProvider<AuthController>(
          create: (context) => AuthController(context.read()),
        ),
        Provider<ProfileRepository>(create: (_) => FirebaseProfileRepository()),
        ChangeNotifierProvider<ProfileController>(
          create: (context) => ProfileController(context.read()),
        ),
        Provider<HomeProfileRepository>(
          create: (_) => FirebaseHomeProfileRepository(),
        ),
        ChangeNotifierProvider<HomeController>(
          create: (context) => HomeController(context.read()),
        ),
        Provider<TechnicalCourseRepository>(
          create: (_) => FirebaseTechnicalCourseRepository(),
        ),
        ChangeNotifierProvider<TechnicalQuizController>(
          create: (context) => TechnicalQuizController(context.read()),
        ),
        Provider<CvUploadRepository>(
          create: (_) => FirebaseCvUploadRepository(),
        ),
        ChangeNotifierProvider<CvScannerController>(
          create: (context) => CvScannerController(context.read()),
        ),
      ],
      child: child,
    );
  }
}
