import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/extensions/app_extensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_image.dart';
import '../controller/restaurant_controller.dart';
import '../model/restaurant_model.dart';
import 'quantity_stepper.dart';
import 'veg_indicator.dart';

class DishItemWidget extends StatelessWidget {
  const DishItemWidget({
    super.key,
    required this.meal,
    required this.controller,
  });

  final MealItem meal;
  final RestaurantController controller;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final location = meal.location;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: VegNonVegIndicator(isVeg: false),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.strMeal,
                  style: AppTextStyles.title,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      l10n.inrPrice(meal.price.toStringAsFixed(2)),
                      style: AppTextStyles.subtitle,
                    ),
                    const Spacer(),
                    Text(
                      l10n.calories(meal.calories.toString()),
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
                if (location.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    location,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: colors.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Obx(() {
                  final quantity = controller.getMealQuantity(meal.idMeal);
                  return QuantityStepper(
                    quantity: quantity,
                    backgroundColor: colors.secondary,
                    onIncrement: () => controller.incrementMeal(meal),
                    onDecrement: () => controller.decrementMeal(meal),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(width: 12),
          AppImage(
            path: meal.strMealThumb,
            width: 75,
            height: 75,
            borderRadius: BorderRadius.circular(8),
            fallbackIcon: Icons.restaurant_rounded,
          ),
        ],
      ),
    );
  }
}
