import 'restaurant_model.dart';

class CartItem {
  final MealItem meal;
  int quantity;

  CartItem({
    required this.meal,
    this.quantity = 1,
  });

  double get totalPrice => meal.price * quantity;
}
