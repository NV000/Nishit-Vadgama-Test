import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/extensions/app_extensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_image.dart';
import '../../auth/controller/auth_controller.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final colors = context.colors;
    final l10n = context.l10n;

    return Drawer(
      backgroundColor: colors.surface,
      child: Column(
        children: [
          Obx(() {
            final user = authController.currentUser.value;
            final name = user?.name ?? l10n.userDefault;
            final uid = user?.uid ?? '${user?.id ?? '410'}';
            final photoUrl = user?.photoUrl;

            return Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  top: 50, bottom: 28, left: 20, right: 20),
              decoration: BoxDecoration(
                color: colors.secondary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  AppImage(
                    path: photoUrl,
                    width: 76,
                    height: 76,
                    isCircle: true,
                    errorWidget: Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        color: colors.surface,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          name.isNotEmpty ? name[0].toUpperCase() : 'U',
                          style: AppTextStyles.heading1.copyWith(
                            color: colors.secondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    name,
                    style: AppTextStyles.heading2.copyWith(
                      color: colors.onSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.userId(uid),
                    style: AppTextStyles.subtitle.copyWith(
                      color: colors.onSecondary.withValues(alpha: 0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 12),
          ListTile(
            leading: Icon(
              Icons.logout_rounded,
              color: colors.onSurface.withValues(alpha: 0.6),
              size: 26,
            ),
            title: Text(
              l10n.logout,
              style: AppTextStyles.title.copyWith(
                color: colors.onSurface.withValues(alpha: 0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              _confirmLogout(context, authController);
            },
          ),
        ],
      ),
    );
  }

  void _confirmLogout(BuildContext context, AuthController authController) {
    final colors = context.colors;
    final l10n = context.l10n;

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(l10n.logoutConfirmTitle, style: AppTextStyles.title),
        content: Text(l10n.logoutConfirmMessage, style: AppTextStyles.body),
        actions: [
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: colors.error,
              foregroundColor: colors.onSecondary,
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              authController.logout();
            },
            child: Text(l10n.logout, style: AppTextStyles.subtitle),
          ),
          SizedBox(height: 10),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: colors.outline,
              foregroundColor: colors.primary,
            ),
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.cancel, style: AppTextStyles.subtitle),
          ),
        ],
      ),
    );
  }
}
