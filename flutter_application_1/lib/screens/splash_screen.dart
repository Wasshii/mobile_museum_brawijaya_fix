import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/ambient_background.dart';
import 'login_screen.dart';

/// Halaman pertama — Splash Screen Museum Brawijaya
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.forward();

    // Timer selama ~8 detik
    _timer = Timer(const Duration(seconds: 8), _navigateToLogin);
  }

  void _navigateToLogin() {
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBase,
      body: AmbientBackground(
        child: Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: child,
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Museum\nBrawijaya',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                  height: 1.25,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
