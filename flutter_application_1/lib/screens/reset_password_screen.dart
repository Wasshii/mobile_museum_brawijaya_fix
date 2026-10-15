import 'package:flutter/material.dart';
import '../services/dummy_auth_service.dart';
import '../theme/app_colors.dart';
import '../widgets/ambient_background.dart';
import '../widgets/auth_card_panel.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/draggable_feedback_sheet.dart';
import '../widgets/notification_dialog.dart';
import '../widgets/primary_button.dart';

/// Halaman Reset Password Screen Museum Brawijaya
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final DummyAuthService _authService = DummyAuthService();

  bool _isLoading = false;
  String? _emailError;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleConfirmReset() async {
    if (_isLoading) return;

    setState(() => _emailError = null);
    final email = _emailController.text.trim();

    // Kondisi A — Email kosong atau format tidak valid
    if (email.isEmpty) {
      setState(() {
        _emailError = 'Email yang terkait wajib diisi';
      });
      return;
    }

    if (!_authService.isValidEmailFormat(email)) {
      setState(() {
        _emailError = 'Format email tidak valid (contoh: nama@domain.com)';
      });
      return;
    }

    setState(() => _isLoading = true);

    final isRegistered = await _authService.checkEmailExists(email);

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (!isRegistered) {
      // Kondisi B — Email tidak terdaftar (Tampilkan pop-up, jangan buka sheet)
      NotificationDialog.show(
        context,
        title: 'Pemberitahuan',
        message: 'Akun tidak terdaftar',
        buttonText: 'Mengerti',
      );
    } else {
      // Kondisi C — Email terdaftar (Munculkan DraggableFeedbackSheet)
      final masked = _authService.maskEmail(email);

      DraggableFeedbackSheet.show(
        context,
        maskedEmail: masked,
        onResendRequested: () {},
      );
    }
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
                              // 1. Judul "Reset Kata Sandi" (2 baris)
                              const Text(
                                'Reset\nKata Sandi',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.textWhite,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.2,
                                  height: 1.25,
                                ),
                              ),
                              const SizedBox(height: 12.0),

                              // 2. Keterangan
                              const Text(
                                'Lengkapi data di bawah untuk\nverifikasi identitas Anda.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: 13.0,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 28.0),

                              // 3. Field Email yang terkait
                              CustomTextField(
                                controller: _emailController,
                                hintText: 'Email yang terkait',
                                keyboardType: TextInputType.emailAddress,
                                errorText: _emailError,
                                onChanged: (_) {
                                  if (_emailError != null) {
                                    setState(() => _emailError = null);
                                  }
                                },
                              ),
                              const SizedBox(height: 24.0),

                              // 4 & 5. Tombol Kembali & Konfirmasi
                              Row(
                                children: [
                                  // Tombol Kembali
                                  Expanded(
                                    flex: 4,
                                    child: SecondaryIconButton(
                                      text: 'Kembali',
                                      icon: Icons.undo_rounded,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12.0),

                                  // Tombol Konfirmasi
                                  Expanded(
                                    flex: 5,
                                    child: PrimaryButton(
                                      text: 'Konfirmasi',
                                      isLoading: _isLoading,
                                      onPressed: _handleConfirmReset,
                                    ),
                                  ),
                                ],
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
