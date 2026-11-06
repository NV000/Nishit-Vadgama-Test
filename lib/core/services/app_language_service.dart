import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../generated/l10n.dart';
import '../storage/secure_storage.dart';

class AppLanguageService extends GetxService {
  static AppLanguageService get to => Get.find();

  static const Locale englishLocale = Locale('en');
  static const Locale hindiLocale = Locale('hi');

  static const List<Locale> supportedLocales = [
    englishLocale,
    hindiLocale,
  ];

  final Rx<Locale> currentLocale = englishLocale.obs;

  @override
  void onInit() {
    super.onInit();
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final savedCode = await SecureStorage.getLocale();
    if (savedCode != null && savedCode.isNotEmpty) {
      final matchedLocale = supportedLocales.firstWhere(
        (l) => l.languageCode == savedCode,
        orElse: () => englishLocale,
      );
      currentLocale.value = matchedLocale;
      await Get.updateLocale(matchedLocale);
      await S.load(matchedLocale);
    }
  }

  Future<void> changeLocale(Locale locale) async {
    if (currentLocale.value.languageCode == locale.languageCode) return;
    currentLocale.value = locale;
    await SecureStorage.setLocale(locale.languageCode);
    await Get.updateLocale(locale);
    await S.load(locale);
  }

  String getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'hi':
        return S.current.hindi;
      case 'en':
      default:
        return S.current.english;
    }
  }
}

