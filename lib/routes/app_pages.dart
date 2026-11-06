import 'package:get/get.dart';
import '../features/auth/binding/auth_binding.dart';
import '../features/auth/view/login_page.dart';
import '../features/auth/view/register_page.dart';
import '../features/home/binding/home_binding.dart';
import '../features/home/view/home_page.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      bindings: [AuthBinding(), HomeBinding()],
      transition: Transition.fadeIn,
    ),
  ];
}

