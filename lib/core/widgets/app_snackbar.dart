import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      SnackType.success => (const Color(0xFF10B981), Icons.check_circle_rounded),
      SnackType.error => (const Color(0xFFEF4444), Icons.error_rounded),
      SnackType.info => (const Color(0xFF2563EB), Icons.info_rounded),
    };

    Get.rawSnackbar(
      message: message,
      title: title,
      backgroundColor: bg,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 10,
      duration: duration,
      icon: Icon(icon, color: Colors.white, size: 24),
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
      ),
      titleText: title != null
          ? Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
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

