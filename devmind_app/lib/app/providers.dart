import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../features/auth/data/repositories/firebase_profile_repository.dart';
import '../features/auth/data/sources/auth_remote_data_source.dart';
import '../features/auth/domain/repositories/profile_repository.dart';
import '../features/auth/presentation/controllers/auth_controller.dart';
import '../features/auth/presentation/controllers/profile_controller.dart';
import '../features/home/data/repositories/firebase_home_profile_repository.dart';
import '../features/home/domain/repositories/home_profile_repository.dart';
import '../features/home/presentation/controllers/home_controller.dart';

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
      ],
      child: child,
    );
  }
}
