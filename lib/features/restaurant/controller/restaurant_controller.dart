import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/extensions/app_extensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_snackbar.dart';
import '../../../routes/app_routes.dart';
import '../../auth/controller/auth_controller.dart';
import '../model/cart_item.dart';
import '../model/restaurant_model.dart';
import '../repository/restaurant_repository.dart';

class RestaurantController extends GetxController {
  final RestaurantRepository _repo = RestaurantRepository();
  AuthController get auth => Get.find<AuthController>();

  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  final RxList<MealCategory> categories = <MealCategory>[].obs;
  final RxMap<String, List<MealItem>> categoryMeals = <String, List<MealItem>>{}.obs;
  final RxMap<String, bool> categoryLoading = <String, bool>{}.obs;

  final RxMap<String, CartItem> cart = <String, CartItem>{}.obs;

  int get totalCartCount =>
      cart.values.fold(0, (sum, item) => sum + item.quantity);

  int get uniqueDishesCount => cart.length;

  double get totalCartAmount =>
      cart.values.fold(0.0, (sum, item) => sum + item.totalPrice);

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await _repo.getCategories();
    isLoading.value = false;

    result.fold(
      (err) => errorMessage.value = err,
      (data) {
        categories.assignAll(data);
        if (data.isNotEmpty) {
          for (final cat in data) {
            fetchMealsForCategory(cat.strCategory);
          }
        }
      },
    );
  }

  Future<void> fetchMealsForCategory(String category) async {
    if (categoryMeals.containsKey(category)) return;

    categoryLoading[category] = true;
    final result = await _repo.getMealsByCategory(category);
    categoryLoading[category] = false;

    result.fold(
      (_) => categoryMeals[category] = <MealItem>[],
      (meals) => categoryMeals[category] = meals,
    );
  }

  int getMealQuantity(String idMeal) {
    return cart[idMeal]?.quantity ?? 0;
  }

  void incrementMeal(MealItem meal) {
    final current = cart[meal.idMeal];
    if (current == null) {
      cart[meal.idMeal] = CartItem(meal: meal, quantity: 1);
    } else {
      current.quantity++;
      cart.refresh();
    }
  }

  void decrementMeal(MealItem meal) {
    final current = cart[meal.idMeal];
    if (current == null) return;

    if (current.quantity > 1) {
      current.quantity--;
      cart.refresh();
    } else {
      cart.remove(meal.idMeal);
    }
  }

  void clearCart() {
    cart.clear();
  }

  void placeOrder(BuildContext context) {
    final l10n = context.l10n;

    if (cart.isEmpty) {
      AppSnackbar.error(l10n.cartIsEmpty);
      return;
    }

    final colors = context.colors;

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: colors.secondary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_rounded,
                color: colors.secondary,
                size: 38,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.orderSuccessfullyPlaced,
              style: AppTextStyles.title.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: colors.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  clearCart();
                  Get.offAllNamed(AppRoutes.home);
                },
                child: Text(l10n.ok, style: AppTextStyles.subtitle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
