import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../features/auth/presentation/controllers/auth_controller.dart';
import 'providers.dart';
import 'router.dart';
import 'theme/app_theme.dart';

class DevMindApp extends StatelessWidget {
  const DevMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(child: const _DevMindRouter());
  }
}

class _DevMindRouter extends StatefulWidget {
  const _DevMindRouter();

  @override
  State<_DevMindRouter> createState() => _DevMindRouterState();
}

class _DevMindRouterState extends State<_DevMindRouter> {
  GoRouter? _router;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _router ??= createAppRouter(context.read<AuthController>());
  }

  @override
  Widget build(BuildContext context) {
    final router = _router;
    if (router == null) {
      return const SizedBox.shrink();
    }

    return MaterialApp.router(
      title: 'DevMind AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: router,
    );
  }
}
