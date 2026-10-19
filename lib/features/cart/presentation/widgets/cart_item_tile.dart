import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/network_meal_image.dart';
import '../../domain/entities/cart_item.dart';
import '../cubit/cart_cubit.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({super.key, required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    final meal = item.meal;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: NetworkMealImage(url: meal.thumbnail, size: 'small'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(meal.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
                Text(context.l10n.priceLabel(item.total.toStringAsFixed(2))),
              ],
            ),
          ),
          IconButton(
            tooltip: context.l10n.remove,
            onPressed: () => cubit.remove(meal.id),
            icon: const Icon(Icons.delete_outline),
          ),
          IconButton(
            onPressed: () => cubit.decrease(meal.id),
            icon: const Icon(Icons.remove_circle_outline),
          ),
          Text('${item.quantity}'),
          IconButton(
            onPressed: () => cubit.addMeal(meal),
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
    );
  }
}
