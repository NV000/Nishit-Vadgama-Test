import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../generated/l10n.dart';
import '../services/app_language_service.dart';
import '../theme/app_colors.dart';

class LanguageSwitchWidget extends StatelessWidget {
  const LanguageSwitchWidget({super.key});

  static void showLanguageBottomSheet(BuildContext context) {
    final languageService = AppLanguageService.to;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  const Icon(Icons.language_rounded, color: AppColors.primary, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    S.current.selectLanguage,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
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
                          ? AppColors.primaryLight
                          : AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.border,
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
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w400,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textPrimary,
                        ),
                      ),
                      trailing: isSelected
                          ? const Icon(
                              Icons.check_circle_rounded,
                              color: AppColors.primary,
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

    return Obx(() {
      final currentCode = languageService.currentLocale.value.languageCode.toUpperCase();
      return InkWell(
        onTap: () => showLanguageBottomSheet(context),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.pastelBlue),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.language_rounded,
                size: 16,
                color: AppColors.primary,
              ),
              const SizedBox(width: 4),
              Text(
                currentCode,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

