import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/helpers/app_assets.dart';

import '../../../core/extensions/app_extensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_image.dart';
import '../../../core/widgets/app_page.dart';
import '../controller/auth_controller.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AppPage(
      confirmExitOnBack: true,
      backgroundColor: colors.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              const Spacer(flex: 2),
              AppImage(
                path: AppAssets.firebaseIcon,
                width: 140,
                height: 140,
                fit: BoxFit.contain,
                fallbackIcon: Icons.local_fire_department_rounded,
              ),
              const Spacer(flex: 3),
              Obx(() => AppButton(
                    label: context.l10n.google,
                    isLoading: controller.isGoogleLoading.value,
                    backgroundColor: colors.tertiary,
                    textColor: colors.onTertiary,
                    height: 52,
                    borderRadius: 26,
                    icon: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: colors.surface,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          'G',
                          style: AppTextStyles.heading2.copyWith(
                            color: colors.tertiary,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    onPressed: controller.loginWithGoogle,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
