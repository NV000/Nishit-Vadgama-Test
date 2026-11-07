import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum SnackType { success, error, info }

class AppSnackbar {
  AppSnackbar._();

  static void show({
    required String message,
    SnackType type = SnackType.info,
    String? title,
    Duration duration = const Duration(seconds: 3),
  }) {
    final (bg, icon) = switch (type) {
      SnackType.success => (AppColors.green, Icons.check_circle_rounded),
      SnackType.error => (AppColors.red, Icons.error_rounded),
      SnackType.info => (AppColors.blue, Icons.info_rounded),
    };

    Get.rawSnackbar(
      message: message,
      title: title,
      backgroundColor: bg,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 10,
      duration: duration,
      icon: Icon(icon, color: AppColors.white, size: 24),
      messageText: Text(
        message,
        style: AppTextStyles.body.copyWith(color: AppColors.white),
      ),
      titleText: title != null
          ? Text(
              title,
              style: AppTextStyles.title.copyWith(color: AppColors.white),
            )
          : null,
    );
  }

  static void success(String message, {String? title}) =>
      show(message: message, type: SnackType.success, title: title ?? 'Success');

  static void error(String message, {String? title}) =>
      show(message: message, type: SnackType.error, title: title ?? 'Error');

  static void info(String message, {String? title}) =>
      show(message: message, type: SnackType.info, title: title);
}
