import 'package:flutter/material.dart';

import 'providers.dart';
import 'router.dart';
import 'theme/app_theme.dart';

class DevMindApp extends StatelessWidget {
  const DevMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: MaterialApp.router(
        title: 'DevMind AI',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routerConfig: appRouter,
      ),
    );
  }
}
