import 'package:flutter/material.dart';
import '../models/auth_result.dart';
import '../services/dummy_auth_service.dart';
import '../theme/app_colors.dart';
import '../widgets/ambient_background.dart';
import '../widgets/auth_card_panel.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/google_sign_in_button.dart';
import '../widgets/notification_dialog.dart';
import '../widgets/primary_button.dart';
import 'dashboard_screen.dart';
import 'reset_password_screen.dart';

/// Halaman kedua — Login Screen Museum Brawijaya
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final DummyAuthService _authService = DummyAuthService();

  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _isGoogleLoading = false;

  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleEmailLogin() async {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Kondisi A — Email atau password kosong / format salah
    bool hasEmptyField = false;
    if (email.isEmpty) {
      _emailError = 'Email tidak boleh kosong';
      hasEmptyField = true;
    } else if (!_authService.isValidEmailFormat(email)) {
      _emailError = 'Format email tidak valid';
      hasEmptyField = true;
    }

    if (password.isEmpty) {
      _passwordError = 'Kata sandi tidak boleh kosong';
      hasEmptyField = true;
    }

    if (hasEmptyField) {
      setState(() {});
      return;
    }

    setState(() => _isLoading = true);

    final result = await _authService.login(email: email, password: password);

    if (!mounted) return;
    setState(() => _isLoading = false);

    switch (result.status) {
      case AuthStatus.emailNotFound:
        // Kondisi B — Email tidak terdaftar
        NotificationDialog.show(
          context,
          title: 'Perhatian',
          message: 'Akun tidak terdaftar',
          buttonText: 'Coba Lagi',
        );
        break;

      case AuthStatus.wrongPassword:
        // Kondisi C — Email terdaftar, tetapi password salah
        NotificationDialog.show(
          context,
          title: 'Kata Sandi Keliru',
          message: 'Password salah',
          buttonText: 'Coba Lagi',
        );
        break;

      case AuthStatus.success:
        // Kondisi D — Autentikasi berhasil menuju Dashboard
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                DashboardScreen(user: result.user!),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
        break;

      case AuthStatus.emptyFields:
        break;
    }
  }

  void _handleGoogleLogin() async {
    setState(() => _isGoogleLoading = true);
    final result = await _authService.loginWithGoogle();

    if (!mounted) return;
    setState(() => _isGoogleLoading = false);

    if (result.isSuccess && result.user != null) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              DashboardScreen(user: result.user!),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  void _navigateToResetPassword() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const ResetPasswordScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 0.05);
          const end = Offset.zero;
          const curve = Curves.easeOutCubic;
          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  void _handleCreateAccount() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur pendaftaran akun baru akan segera tersedia.'),
        duration: Duration(seconds: 2),
        backgroundColor: AppColors.cardBackground,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBase,
      body: AmbientBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: AuthCardPanel(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // 1. Judul "Log in"
                              const Text(
                                'Log in',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.textWhite,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.2,
                                ),
                              ),
                              const SizedBox(height: 28.0),

                              // 2. Field Email
                              CustomTextField(
                                controller: _emailController,
                                hintText: 'Email',
                                keyboardType: TextInputType.emailAddress,
                                errorText: _emailError,
                                onChanged: (_) {
                                  if (_emailError != null) {
                                    setState(() => _emailError = null);
                                  }
                                },
                              ),
                              const SizedBox(height: 14.0),

                              // 3 & 4. Field Kata Sandi
                              CustomTextField(
                                controller: _passwordController,
                                hintText: 'Kata Sandi',
                                isPassword: true,
                                obscureText: _obscurePassword,
                                onToggleVisibility: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                                errorText: _passwordError,
                                onChanged: (_) {
                                  if (_passwordError != null) {
                                    setState(() => _passwordError = null);
                                  }
                                },
                              ),
                              const SizedBox(height: 18.0),

                              // 5. Tombol "Login"
                              PrimaryButton(
                                text: 'Login',
                                isLoading: _isLoading,
                                onPressed: _handleEmailLogin,
                              ),
                              const SizedBox(height: 16.0),

                              // 6. "Lupa Password ?"
                              Center(
                                child: InkWell(
                                  onTap: _navigateToResetPassword,
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0,
                                    ),
                                    child: Text(
                                      'Lupa Password ?',
                                      style: TextStyle(
                                        color: AppColors.textWhite,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),

                              // 7. Divider "atau"
                              Row(
                                children: [
                                  const Expanded(
                                    child: Divider(
                                      color: AppColors.dividerLine,
                                      thickness: 1.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14.0,
                                    ),
                                    child: Text(
                                      'atau',
                                      style: TextStyle(
                                        color: AppColors.dividerText,
                                        fontSize: 13.0,
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    child: Divider(
                                      color: AppColors.dividerLine,
                                      thickness: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18.0),

                              // 8. Tombol "Lanjutkan dengan Google"
                              GoogleSignInButton(
                                isLoading: _isGoogleLoading,
                                onPressed: _handleGoogleLogin,
                              ),
                              const SizedBox(height: 24.0),

                              // 9. "Tidak meiliki akun ? Buat Akun Baru"
                              Center(
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    const Text(
                                      'Tidak meiliki akun ? ',
                                      style: TextStyle(
                                        color: AppColors.textMuted,
                                        fontSize: 12.5,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: _handleCreateAccount,
                                      child: const Text(
                                        'Buat Akun Baru',
                                        style: TextStyle(
                                          color: AppColors.primaryGreen,
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
