import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppHelper {
  AppHelper._();

  static bool isLoading = false;

  static void showLoading() {
    if (!Get.isDialogOpen!) {
      Get.dialog(
        const _LoadingDialog(),
        barrierDismissible: false,
      );
    }
    isLoading = true;
  }

  static void hideLoading() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    isLoading = false;
  }

  static String getInitials(String name) {
    if (name.trim().isEmpty) return '';
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }
}

class _LoadingDialog extends StatelessWidget {
  const _LoadingDialog();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
