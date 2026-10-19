import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../home/domain/entities/meal_entity.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/entities/delivery_address.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/payment/payment_method.dart';
import '../../domain/usecases/place_order_usecase.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this._placeOrderUseCase) : super(const CartState());

  final PlaceOrderUseCase _placeOrderUseCase;

  void addMeal(MealEntity meal) {
    final items = [...state.items];
    final index = items.indexWhere((i) => i.meal.id == meal.id);
    if (index == -1) {
      items.add(CartItem(meal: meal, quantity: 1));
    } else {
      items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
    }
    emit(state.copyWith(items: items));
  }

  void decrease(String mealId) {
    final items = [...state.items];
    final index = items.indexWhere((i) => i.meal.id == mealId);
    if (index == -1) return;
    if (items[index].quantity <= 1) {
      items.removeAt(index);
    } else {
      items[index] = items[index].copyWith(quantity: items[index].quantity - 1);
    }
    emit(state.copyWith(items: items));
  }

  void remove(String mealId) {
    emit(state.copyWith(
      items: state.items.where((i) => i.meal.id != mealId).toList(),
    ));
  }

  void setFulfilment({required bool isDelivery}) {
    emit(state.copyWith(isDelivery: isDelivery));
  }

  void clear() {
    emit(state.copyWith(items: []));
  }

  Future<void> placeOrder({
    required String userId,
    required PaymentMethod payment,
    required DeliveryAddress address,
  }) async {
    emit(state.copyWith(items: state.items, status: CartStatus.placing));
    try {
      await payment.pay(state.total);
      final order = OrderEntity(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        items: state.items,
        total: state.total,
        paymentMethod: payment.id,
        address: address.formatted,
        createdAt: DateTime.now(),
      );
      await _placeOrderUseCase(userId, order);
      // The order is saved, so the cart is cleared.
      emit(state.copyWith(items: [], status: CartStatus.placed));
    } on AppFailure catch (e) {
      emit(state.copyWith(status: CartStatus.failure, failure: e.type));
    } catch (_) {
      emit(state.copyWith(
          status: CartStatus.failure, failure: FailureType.unknown));
    }
  }
}
