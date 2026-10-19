import 'package:equatable/equatable.dart';

import '../../../home/domain/entities/meal_entity.dart';

class CartItem extends Equatable {
  const CartItem({required this.meal, required this.quantity});

  final MealEntity meal;
  final int quantity;

  double get total => meal.price * quantity;

  CartItem copyWith({int? quantity}) =>
      CartItem(meal: meal, quantity: quantity ?? this.quantity);

  @override
  List<Object?> get props => [meal, quantity];
}
