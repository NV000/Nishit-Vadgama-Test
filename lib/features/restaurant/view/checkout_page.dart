import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/extensions/app_extensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_empty_widget.dart';
import '../../../core/widgets/app_page.dart';
import '../controller/restaurant_controller.dart';
import '../widgets/quantity_stepper.dart';
import '../widgets/veg_indicator.dart';

class CheckoutPage extends GetView<RestaurantController> {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;

    return AppPage(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0.5,
        leading: BackButton(color: colors.onSurface.withValues(alpha: 0.7)),
        title: Text(
          l10n.orderSummary,
          style: AppTextStyles.heading2.copyWith(
            color: colors.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ),
      child: Obx(() {
        final items = controller.cart.values.toList();
        if (items.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppEmptyWidget(
                  message: l10n.noItemsInCart,
                  icon: Icons.shopping_cart_outlined,
                  onRetry: () => Get.back(),
                  retryLabel: l10n.backToMenu,
                ),
              ],
            ),
          );
        }

        final dishesCount = controller.uniqueDishesCount;
        final totalItems = controller.totalCartCount;
        final totalAmount = controller.totalCartAmount;

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: colors.outline),
                    boxShadow: [
                      BoxShadow(
                        color: colors.onSurface.withValues(alpha: 0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: colors.primary,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Text(
                          l10n.dishesAndItemsCount(dishesCount, totalItems),
                          style: AppTextStyles.title.copyWith(
                            color: colors.onPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        separatorBuilder: (_, __) => Divider(
                          height: 1,
                          thickness: 0.8,
                          color: colors.outline,
                        ),
                        itemBuilder: (_, index) {
                          final item = items[index];
                          final meal = item.meal;
                          final location = meal.location;

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 16,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: VegNonVegIndicator(isVeg: false),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        meal.strMeal,
                                        style: AppTextStyles.title,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        l10n.inrPrice(
                                            meal.price.toStringAsFixed(2)),
                                        style: AppTextStyles.subtitle,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        l10n.calories(meal.calories.toString()),
                                        style: AppTextStyles.bodySmall.copyWith(
                                          color: colors.onSurface
                                              .withValues(alpha: 0.6),
                                        ),
                                      ),
                                      if (location.isNotEmpty) ...[
                                        const SizedBox(height: 2),
                                        Text(
                                          location,
                                          style:
                                              AppTextStyles.bodySmall.copyWith(
                                            color: colors.onSurface
                                                .withValues(alpha: 0.6),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 150,
                                  child: Column(
                                    children: [
                                      QuantityStepper(
                                        quantity: item.quantity,
                                        backgroundColor: colors.primary,
                                        onIncrement: () =>
                                            controller.incrementMeal(meal),
                                        onDecrement: () =>
                                            controller.decrementMeal(meal),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        l10n.inrPrice(
                                            item.totalPrice.toStringAsFixed(2)),
                                        style: AppTextStyles.title,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: colors.outline,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 18,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.totalAmount,
                              style: AppTextStyles.title.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              l10n.inrPrice(totalAmount.toStringAsFixed(2)),
                              style: AppTextStyles.title.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colors.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: AppButton(
                  label: l10n.placeOrder,
                  backgroundColor: colors.primary,
                  textColor: colors.onPrimary,
                  height: 52,
                  borderRadius: 26,
                  onPressed: () => controller.placeOrder(context),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
