import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Tombol utama berwarna hijau dengan bentuk pill (kapsul)
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final Widget? prefixIcon;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.height = 48.0,
    this.backgroundColor = AppColors.primaryGreen,
    this.textColor = AppColors.primaryGreenText,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: backgroundColor.withOpacity(0.6),
          foregroundColor: textColor,
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
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon!,
                    const SizedBox(width: 8.0),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Tombol sekunder gelap (seperti tombol 'Kembali' dengan ikon panah)
class SecondaryIconButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;
  final double height;

  const SecondaryIconButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.height = 48.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryButtonBg,
          foregroundColor: AppColors.secondaryButtonText,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: AppColors.secondaryButtonText,
            ),
            const SizedBox(width: 8.0),
            Text(
              text,
              style: const TextStyle(
                color: AppColors.secondaryButtonText,
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
