import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Draggable Feedback Sheet — "Periksa Email Anda"
class DraggableFeedbackSheet extends StatefulWidget {
  final String maskedEmail;
  final VoidCallback? onResendRequested;

  const DraggableFeedbackSheet({
    super.key,
    required this.maskedEmail,
    this.onResendRequested,
  });

  /// Helper untuk menampilkan sheet dengan backdrop blur
  static Future<void> show(
    BuildContext context, {
    required String maskedEmail,
    VoidCallback? onResendRequested,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.65),
      enableDrag: true,
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                child: Container(color: Colors.transparent),
              ),
            ),
            DraggableFeedbackSheet(
              maskedEmail: maskedEmail,
              onResendRequested: onResendRequested,
            ),
          ],
        );
      },
    );
  }

  @override
  State<DraggableFeedbackSheet> createState() => _DraggableFeedbackSheetState();
}

class _DraggableFeedbackSheetState extends State<DraggableFeedbackSheet> {
  static const int _initialCountdown = 30;
  int _countdownSeconds = _initialCountdown;
  Timer? _countdownTimer;
  bool _isResending = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    setState(() {
      _countdownSeconds = _initialCountdown;
    });

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_countdownSeconds > 1) {
        setState(() {
          _countdownSeconds--;
        });
      } else {
        setState(() {
          _countdownSeconds = 0;
        });
        timer.cancel();
      }
    });
  }

  void _handleResend() async {
    if (_countdownSeconds > 0 || _isResending) return;

    setState(() => _isResending = true);
    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;
    setState(() => _isResending = false);

    widget.onResendRequested?.call();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            'Tautan reset password baru berhasil dikirim ulang (Simulasi)'),
        duration: Duration(seconds: 2),
        backgroundColor: AppColors.cardBackground,
      ),
    );

    _startCountdown();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        final velocity = details.primaryVelocity;
        if (velocity != null && (velocity > 150 || velocity < -150)) {
          Navigator.of(context).pop();
        }
      },
      child: SafeArea(
        top: false,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(34.0),
            ),
            border: Border.all(
              color: AppColors.cardBorder,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.7),
                blurRadius: 36,
                offset: const Offset(0, -6),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // A. Drag Handle Pill
              Center(
                child: Container(
                  width: 48.0,
                  height: 5.0,
                  margin: const EdgeInsets.only(top: 6.0, bottom: 24.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF424A45),
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
              ),

              // B. Judul
              const Text(
                'Periksa Email Anda',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 21.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 12.0),

              // C. Deskripsi
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Kami telah mengirim link reset password akun Anda menuju email berikut',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 13.5,
                    height: 1.45,
                  ),
                ),
              ),
              const SizedBox(height: 24.0),

              // D. Ilustrasi Amplop & Kertas
              const EnvelopeIllustration(size: 110.0),
              const SizedBox(height: 22.0),

              // E. Email Tersamar
              Text(
                widget.maskedEmail,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.primaryGreen,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 24.0),

              // F. Informasi Pengiriman Ulang & Countdown
              Center(
                child: _countdownSeconds > 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Tidak menerima email? ',
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 13.0,
                            ),
                          ),
                          Text(
                            'Tunggu $_countdownSeconds Detik',
                            style: const TextStyle(
                              color: Color(0xFF6EAF82),
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : InkWell(
                        onTap: _handleResend,
                        borderRadius: BorderRadius.circular(8.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 4.0,
                          ),
                          child: Text(
                            _isResending
                                ? 'Mengirim ulang...'
                                : 'Kirim ulang email',
                            style: const TextStyle(
                              color: AppColors.primaryGreen,
                              fontSize: 13.5,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryGreen,
                            ),
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}

/// Ilustrasi amplop dengan kertas di dalamnya (1:1 sesuai Screenshot 2)
class EnvelopeIllustration extends StatelessWidget {
  final double size;

  const EnvelopeIllustration({super.key, this.size = 110.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 0.72,
      child: CustomPaint(
        painter: _EnvelopePainter(),
      ),
    );
  }
}

class _EnvelopePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Kertas Surat
    final paperWidth = w * 0.62;
    final paperHeight = h * 0.65;
    final paperLeft = (w - paperWidth) / 2;
    final paperTop = h * 0.08;

    final paperPaint = Paint()
      ..color = const Color(0xFFD4D8E2)
      ..style = PaintingStyle.fill;

    final paperShadow = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final paperRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(paperLeft, paperTop, paperWidth, paperHeight),
      const Radius.circular(5.0),
    );

    canvas.drawRRect(paperRect, paperShadow);
    canvas.drawRRect(paperRect, paperPaint);

    // 2. Flap segitiga atas terbuka
    final backFlapPath = Path()
      ..moveTo(w * 0.1, h * 0.42)
      ..lineTo(w * 0.5, h * 0.16)
      ..lineTo(w * 0.9, h * 0.42)
      ..close();

    final backFlapPaint = Paint()
      ..color = const Color(0xFF2C3244)
      ..style = PaintingStyle.fill;
    canvas.drawPath(backFlapPath, backFlapPaint);

    // 3. Badan Amplop
    final envelopePath = Path()
      ..moveTo(w * 0.08, h * 0.42)
      ..lineTo(w * 0.5, h * 0.68)
      ..lineTo(w * 0.92, h * 0.42)
      ..lineTo(w * 0.92, h * 0.96)
      ..lineTo(w * 0.08, h * 0.96)
      ..close();

    final envelopePaint = Paint()
      ..color = const Color(0xFF383E54)
      ..style = PaintingStyle.fill;
    canvas.drawPath(envelopePath, envelopePaint);

    // 4. Lipatan samping kiri & kanan
    final leftFold = Path()
      ..moveTo(w * 0.08, h * 0.42)
      ..lineTo(w * 0.5, h * 0.76)
      ..lineTo(w * 0.08, h * 0.96)
      ..close();

    final foldPaint = Paint()
      ..color = const Color(0xFF2E3448)
      ..style = PaintingStyle.fill;
    canvas.drawPath(leftFold, foldPaint);

    final rightFold = Path()
      ..moveTo(w * 0.92, h * 0.42)
      ..lineTo(w * 0.5, h * 0.76)
      ..lineTo(w * 0.92, h * 0.96)
      ..close();
    canvas.drawPath(rightFold, foldPaint);

    // 5. Lipatan bawah amplop
    final bottomFold = Path()
      ..moveTo(w * 0.08, h * 0.96)
      ..lineTo(w * 0.5, h * 0.72)
      ..lineTo(w * 0.92, h * 0.96)
      ..close();

    final bottomPaint = Paint()
      ..color = const Color(0xFF32384C)
      ..style = PaintingStyle.fill;
    canvas.drawPath(bottomFold, bottomPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
