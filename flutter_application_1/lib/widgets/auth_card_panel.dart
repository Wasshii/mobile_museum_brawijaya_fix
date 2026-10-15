import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Panel kartu melayang yang membungkus form Login dan Reset Kata Sandi
class AuthCardPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const AuthCardPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          padding: padding,
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(36.0),
            border: Border.all(
              color: AppColors.cardBorder,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 24.0,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
