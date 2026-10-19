import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../domain/entities/meal_entity.dart';
import 'hot_offer_card.dart';

class HotOffersWidget extends StatelessWidget {
  const HotOffersWidget(
      {super.key, required this.offers, required this.onOpen});

  final List<MealEntity> offers;
  final ValueChanged<MealEntity> onOpen;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: offers.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final meal = offers[index];
          return HotOfferCard(
            meal: meal,
            onTap: () => onOpen(meal),
            onAdd: () {
              context.read<CartCubit>().addMeal(meal);
              context.showSnack(context.l10n.addedToCart(meal.name));
            },
          );
        },
      ),
    );
  }
}
