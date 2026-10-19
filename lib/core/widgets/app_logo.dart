import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Simple StreetBite logo: a rounded tile with a food icon.
class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size = 96,
    this.background = Colors.white,
    this.iconColor = AppColors.primary,
  });

  final double size;
  final Color background;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(size * 0.26),
      ),
      child: Icon(Icons.fastfood_rounded, size: size * 0.55, color: iconColor),
    );
  }
}
