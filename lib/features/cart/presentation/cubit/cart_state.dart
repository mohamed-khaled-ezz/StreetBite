import 'package:equatable/equatable.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/app_failure.dart';
import '../../domain/entities/cart_item.dart';

enum CartStatus { idle, placing, placed, failure }

class CartState extends Equatable {
  const CartState({
    this.items = const [],
    this.isDelivery = true,
    this.status = CartStatus.idle,
    this.failure,
  });

  final List<CartItem> items;
  final bool isDelivery;
  final CartStatus status;
  final FailureType? failure;

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => items.fold(0, (sum, item) => sum + item.total);

  double get deliveryFee =>
      isDelivery && items.isNotEmpty ? AppConstants.deliveryFee : 0;

  double get serviceFee => items.isEmpty ? 0 : AppConstants.serviceFee;

  double get total => subtotal + deliveryFee + serviceFee;

  int quantityOf(String mealId) {
    for (final item in items) {
      if (item.meal.id == mealId) return item.quantity;
    }
    return 0;
  }

  CartState copyWith({
    List<CartItem>? items,
    bool? isDelivery,
    CartStatus? status,
    FailureType? failure,
  }) {
    return CartState(
      items: items ?? this.items,
      isDelivery: isDelivery ?? this.isDelivery,
      status: status ?? CartStatus.idle,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [items, isDelivery, status, failure];
}
