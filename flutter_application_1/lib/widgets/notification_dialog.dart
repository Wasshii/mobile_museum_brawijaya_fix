import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Dialog pop-up modular untuk pesan kesalahan validasi ("Akun tidak terdaftar", "Password salah")
class NotificationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback? onConfirm;

  const NotificationDialog({
    super.key,
    required this.title,
    required this.message,
    this.buttonText = 'Mengerti',
    this.onConfirm,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    String buttonText = 'Mengerti',
    VoidCallback? onConfirm,
  }) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.65),
      builder: (context) => NotificationDialog(
        title: title,
        message: message,
        buttonText: buttonText,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 26.0),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(28.0),
          border: Border.all(
            color: AppColors.cardBorder,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 28,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 54.0,
              height: 54.0,
              decoration: BoxDecoration(
                color: AppColors.errorRed.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                color: AppColors.errorRed,
                size: 30.0,
              ),
            ),
            const SizedBox(height: 18.0),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textWhite,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 14.0,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24.0),
            SizedBox(
              width: double.infinity,
              height: 44.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onConfirm != null) onConfirm!();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
