import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Tombol masuk dengan Google bergaya pill putih sesuai desain referensi
class GoogleSignInButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const GoogleSignInButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.googleButtonBg,
          foregroundColor: AppColors.googleButtonText,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  color: Colors.black87,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const GoogleLogoIcon(size: 20.0),
                  const SizedBox(width: 12.0),
                  const Text(
                    'Lanjutkan dengan Google',
                    style: TextStyle(
                      color: AppColors.googleButtonText,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Logo 'G' Google dengan 4 warna resmi menggunakan CustomPainter
class GoogleLogoIcon extends StatelessWidget {
  final double size;

  const GoogleLogoIcon({super.key, this.size = 20.0});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _GoogleLogoPainter(),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final center = Offset(w / 2, h / 2);
    final radius = w / 2;

    final strokeWidth = radius * 0.44;
    final arcRadius = radius - (strokeWidth / 2);
    final rect = Rect.fromCircle(center: center, radius: arcRadius);

    final Paint redPaint = Paint()
      ..color = const Color(0xFFEA4335)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final Paint yellowPaint = Paint()
      ..color = const Color(0xFFFBBC05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final Paint greenPaint = Paint()
      ..color = const Color(0xFF34A853)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final Paint bluePaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawArc(rect, 3.14159 * 1.15, 3.14159 * 0.75, false, redPaint);
    canvas.drawArc(rect, 3.14159 * 0.75, 3.14159 * 0.4, false, yellowPaint);
    canvas.drawArc(rect, 3.14159 * 0.2, 3.14159 * 0.55, false, greenPaint);
    canvas.drawArc(rect, -3.14159 * 0.1, 3.14159 * 0.3, false, bluePaint);

    final blueFill = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;
    final barRect = Rect.fromLTWH(
      center.dx - (radius * 0.1),
      center.dy - (strokeWidth / 2),
      radius * 1.1,
      strokeWidth,
    );
    canvas.drawRect(barRect, blueFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
