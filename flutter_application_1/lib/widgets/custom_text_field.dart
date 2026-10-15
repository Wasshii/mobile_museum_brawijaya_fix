import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Text field kustom dengan gaya kapsul (pill) gelap sesuai desain referensi
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;
  final TextInputType keyboardType;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.obscureText = false,
    this.onToggleVisibility,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.inputBackground,
            borderRadius: BorderRadius.circular(26.0),
            border: Border.all(
              color: errorText != null
                  ? AppColors.errorRed
                  : AppColors.inputBorder,
              width: 1.0,
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword ? obscureText : false,
            keyboardType: keyboardType,
            style: const TextStyle(
              color: AppColors.inputText,
              fontSize: 14.5,
            ),
            cursorColor: AppColors.primaryGreen,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: AppColors.inputHint,
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 14.0,
              ),
              border: InputBorder.none,
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.inputHint,
                        size: 20,
                      ),
                      onPressed: onToggleVisibility,
                      splashRadius: 20,
                    )
                  : null,
            ),
          ),
        ),
        if (errorText != null && errorText!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 4.0),
            child: Text(
              errorText!,
              style: const TextStyle(
                color: AppColors.errorRed,
                fontSize: 12.0,
              ),
            ),
          ),
      ],
    );
  }
}
