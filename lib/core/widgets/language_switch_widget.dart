import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../extensions/app_extensions.dart';
import '../services/app_language_service.dart';
import '../theme/app_text_styles.dart';

class LanguageSwitchWidget extends StatelessWidget {
  const LanguageSwitchWidget({super.key});

  static void showLanguageBottomSheet(BuildContext context) {
    final languageService = AppLanguageService.to;
    final colors = context.colors;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.outline,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Icon(Icons.language_rounded, color: colors.primary, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    context.l10n.selectLanguage,
                    style: AppTextStyles.title,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...AppLanguageService.supportedLocales.map((locale) {
                return Obx(() {
                  final isSelected =
                      languageService.currentLocale.value.languageCode ==
                          locale.languageCode;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? colors.primary.withValues(alpha: 0.08)
                          : colors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? colors.primary : colors.outline,
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: ListTile(
                      dense: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onTap: () {
                        languageService.changeLocale(locale);
                        Get.back();
                      },
                      title: Text(
                        languageService.getLanguageName(locale),
                        style: AppTextStyles.subtitle.copyWith(
                          color: isSelected ? colors.primary : colors.onSurface,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                      trailing: isSelected
                          ? Icon(
                              Icons.check_circle_rounded,
                              color: colors.primary,
                              size: 20,
                            )
                          : null,
                    ),
                  );
                });
              }),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageService = AppLanguageService.to;
    final colors = context.colors;

    return Obx(() {
      final currentCode = languageService.currentLocale.value.languageCode.toUpperCase();
      return InkWell(
        onTap: () => showLanguageBottomSheet(context),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colors.outline),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.language_rounded,
                size: 16,
                color: colors.primary,
              ),
              const SizedBox(width: 4),
              Text(
                currentCode,
                style: AppTextStyles.caption.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colors.primary,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
