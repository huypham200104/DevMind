import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

class AppPlaceholderAction {
  const AppPlaceholderAction({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;
}

class AppPlaceholderScreen extends StatelessWidget {
  const AppPlaceholderScreen({
    required this.title,
    required this.description,
    required this.icon,
    this.actions = const [],
    super.key,
  });

  final String title;
  final String description;
  final IconData icon;
  final List<AppPlaceholderAction> actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DevMind AI')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(icon, size: 56, color: AppColors.primary),
                  const SizedBox(height: 24),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  if (actions.isNotEmpty) ...[
                    const SizedBox(height: 32),
                    ...actions.map(
                      (action) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: FilledButton(
                          onPressed: action.onPressed,
                          child: Text(action.label),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
