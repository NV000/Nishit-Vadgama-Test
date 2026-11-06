import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'core/services/app_language_service.dart';
import 'core/services/network_service.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  Get.put<AppLanguageService>(AppLanguageService(), permanent: true);
  Get.put<NetworkService>(NetworkService(), permanent: true);

  runApp(const NVTestApp());
}

class NVTestApp extends StatelessWidget {
  const NVTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageService = AppLanguageService.to;

    return Obx(
      () => GetMaterialApp(
        title: 'Nishit Test',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        locale: languageService.currentLocale.value,
        fallbackLocale: AppLanguageService.englishLocale,
        supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        initialRoute: AppRoutes.login,
        getPages: AppPages.pages,
        defaultTransition: Transition.fadeIn,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: child!,
        ),
      ),
    );
  }
}
