import '../../../home/data/models/meal_model.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.items,
    required super.total,
    required super.paymentMethod,
    required super.address,
    required super.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final rawItems = (json['items'] as List<dynamic>? ?? []);
    return OrderModel(
      id: json['id'] as String,
      items: rawItems.map((raw) {
        final item = Map<String, dynamic>.from(raw as Map);
        final meal = Map<String, dynamic>.from(item['meal'] as Map);
        return CartItem(
          meal: MealModel.fromJson(meal).copyWith(
            price: (item['price'] as num).toDouble(),
          ),
          quantity: item['quantity'] as int,
        );
      }).toList(),
      total: (json['total'] as num).toDouble(),
      paymentMethod: json['paymentMethod'] as String,
      address: (json['address'] as String?) ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  factory OrderModel.fromEntity(OrderEntity order) => OrderModel(
        id: order.id,
        items: order.items,
        total: order.total,
        paymentMethod: order.paymentMethod,
        address: order.address,
        createdAt: order.createdAt,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'items': items
            .map((item) => {
                  'meal': MealModel.fromEntity(item.meal).toJson(),
                  'price': item.meal.price,
                  'quantity': item.quantity,
                })
            .toList(),
        'total': total,
        'paymentMethod': paymentMethod,
        'address': address,
        'createdAt': createdAt.toIso8601String(),
      };
}
