import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/theme_ext.dart';

class GlassyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlassyAppBar({
    super.key,
    this.title = 'DevMind AI',
    this.onBack,
    this.actions,
    this.backgroundColor,
    this.centerTitle = true,
    this.titleSpacing,
  });

  final String title;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool centerTitle;
  final double? titleSpacing;

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context) || onBack != null;

    final appBarWidget = AppBar(
      backgroundColor: backgroundColor ?? context.colors.surface.withAlpha(150),
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      leading:
          canPop
              ? IconButton(
                  tooltip: 'Quay lại',
                  onPressed: () {
                    if (onBack != null) {
                      onBack!();
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(
                    Icons.chevron_left,
                    color: context.colors.onSurface,
                    size: 28,
                  ),
                )
              : null,
      title: Text(
        title,
        style: context.texts.titleLarge?.withColor(context.colors.onSurface).w800.copyWith(letterSpacing: 0),
      ),
      actions: actions,
    );

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: appBarWidget,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
