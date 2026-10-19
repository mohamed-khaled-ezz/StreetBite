import 'package:equatable/equatable.dart';

import 'cart_item.dart';

class OrderEntity extends Equatable {
  const OrderEntity({
    required this.id,
    required this.items,
    required this.total,
    required this.paymentMethod,
    required this.address,
    required this.createdAt,
  });

  /// Minutes spent in each tracking step (simulated progress).
  static const int minutesPerStep = 3;
  static const int stepCount = 4;

  final String id;
  final List<CartItem> items;
  final double total;
  final String paymentMethod;
  final String address;
  final DateTime createdAt;

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  int trackingStep(DateTime now) {
    final step = now.difference(createdAt).inMinutes ~/ minutesPerStep;
    return step.clamp(0, stepCount).toInt();
  }

  /// An order is active until every tracking step has completed.
  bool isActive(DateTime now) => trackingStep(now) < stepCount;

  @override
  List<Object?> get props => [id, items, total, paymentMethod, createdAt];
}
