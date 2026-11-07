import 'package:get/get.dart';
import '../features/auth/binding/auth_binding.dart';
import '../features/auth/view/auth_screen.dart';
import '../features/restaurant/controller/restaurant_controller.dart';
import '../features/restaurant/view/checkout_page.dart';
import '../features/restaurant/view/restaurant_home_page.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final pages = [
    GetPage(
      name: AppRoutes.auth,
      page: () => const AuthScreen(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const RestaurantHomePage(),
      bindings: [
        AuthBinding(),
        BindingsBuilder(() {
          Get.lazyPut<RestaurantController>(() => RestaurantController());
        }),
      ],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.checkout,
      page: () => const CheckoutPage(),
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<RestaurantController>()) {
          Get.lazyPut<RestaurantController>(() => RestaurantController());
        }
      }),
      transition: Transition.rightToLeft,
    ),
  ];
}
