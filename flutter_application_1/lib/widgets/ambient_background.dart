import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Widget pembungkus latar belakang dengan efek ambient green glow di tengah layar
class AmbientBackground extends StatelessWidget {
  final Widget child;

  const AmbientBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.backgroundBase,
        gradient: RadialGradient(
          center: Alignment(0.0, 0.0),
          radius: 0.95,
          colors: [
            AppColors.ambientGreenGlow,
            AppColors.ambientGreen,
            AppColors.backgroundBase,
          ],
          stops: [0.0, 0.35, 0.9],
        ),
      ),
      child: child,
    );
  }
}
