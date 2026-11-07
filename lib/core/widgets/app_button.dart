import 'package:flutter/material.dart';
import '../extensions/app_extensions.dart';
import '../theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 50,
    this.borderRadius = 26,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double height;
  final double borderRadius;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final effectiveBg = backgroundColor ?? colors.primary;
    final effectiveFg = textColor ?? (isOutlined ? effectiveBg : colors.onPrimary);

    final content = isLoading
        ? SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(effectiveFg),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: 10)],
              Text(
                label,
                style: AppTextStyles.button.copyWith(color: effectiveFg),
              ),
            ],
          );

    if (isOutlined) {
      return SizedBox(
        width: width ?? double.infinity,
        height: height,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: effectiveBg),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: content,
        ),
      );
    }

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBg,
          foregroundColor: effectiveFg,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: content,
      ),
    );
  }
}
