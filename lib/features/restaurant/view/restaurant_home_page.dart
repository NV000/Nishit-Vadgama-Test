import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/extensions/app_extensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_loading_widget.dart';
import '../../../core/widgets/app_page.dart';
import '../../../routes/app_routes.dart';
import '../controller/restaurant_controller.dart';
import '../widgets/dish_item_widget.dart';
import '../widgets/side_drawer.dart';

class RestaurantHomePage extends GetView<RestaurantController> {
  const RestaurantHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;

    return AppPage(
      confirmExitOnBack: true,
      backgroundColor: colors.surface,
      child: Obx(() {
        if (controller.isLoading.value) {
          return Scaffold(
            backgroundColor: colors.surface,
            body: AppLoadingWidget(message: l10n.loadingRestaurantMenu),
          );
        }

        final categories = controller.categories;
        if (categories.isEmpty) {
          return Scaffold(
            backgroundColor: colors.surface,
            appBar: AppBar(
              title: Text(l10n.defaultRestaurantName, style: AppTextStyles.heading2),
            ),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline, size: 48, color: colors.outlineVariant),
                  const SizedBox(height: 12),
                  Text(
                    controller.errorMessage.value.isNotEmpty
                        ? controller.errorMessage.value
                        : l10n.noMenuCategoriesFound,
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.fetchCategories,
                    child: Text(l10n.retry, style: AppTextStyles.subtitle),
                  ),
                ],
              ),
            ),
          );
        }

        return DefaultTabController(
          length: categories.length,
          child: Scaffold(
            backgroundColor: colors.surface,
            drawer: const SideDrawer(),
            appBar: AppBar(
              backgroundColor: colors.surface,
              elevation: 1,
              title: Text(
                l10n.defaultRestaurantName,
                style: AppTextStyles.heading2,
              ),
              leading: Builder(
                builder: (ctx) => IconButton(
                  icon: Icon(Icons.menu, color: colors.onSurface),
                  onPressed: () => Scaffold.of(ctx).openDrawer(),
                ),
              ),
              actions: [
                _buildCartIcon(context),
                const SizedBox(width: 8),
              ],
              bottom: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorColor: colors.error,
                indicatorWeight: 3,
                labelColor: colors.error,
                unselectedLabelColor: colors.onSurface.withValues(alpha: 0.6),
                labelStyle: AppTextStyles.subtitle.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: AppTextStyles.subtitle,
                tabs: categories
                    .map((cat) => Tab(text: cat.strCategory))
                    .toList(),
              ),
            ),
            body: TabBarView(
              children: categories.map((cat) {
                return Obx(() {
                  final meals = controller.categoryMeals[cat.strCategory];
                  final isCategoryLoading =
                      controller.categoryLoading[cat.strCategory] ?? false;

                  if (isCategoryLoading && (meals == null || meals.isEmpty)) {
                    return const AppLoadingWidget();
                  }

                  if (meals == null || meals.isEmpty) {
                    return Center(
                      child: Text(
                        l10n.noMenuCategoriesFound,
                        style: AppTextStyles.body,
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: meals.length,
                    separatorBuilder: (_, __) => Divider(
                      height: 1,
                      thickness: 0.8,
                      color: colors.outline,
                    ),
                    itemBuilder: (_, index) {
                      final meal = meals[index];
                      return DishItemWidget(
                        meal: meal,
                        controller: controller,
                      );
                    },
                  );
                });
              }).toList(),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCartIcon(BuildContext context) {
    final colors = context.colors;

    return Obx(() {
      final count = controller.totalCartCount;

      return Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: colors.onSurface.withValues(alpha: 0.8),
              size: 26,
            ),
            onPressed: () => Get.toNamed(AppRoutes.checkout),
          ),
          if (count > 0)
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: colors.error,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 18,
                  minHeight: 18,
                ),
                child: Center(
                  child: Text(
                    '$count',
                    style: AppTextStyles.caption.copyWith(
                      color: colors.onError,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
