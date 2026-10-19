import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../domain/entities/meal_entity.dart';
import 'meal_card_widget.dart';

/// Two-column grid of meals; the aspect ratio adapts to the screen width.
class MealsGrid extends StatelessWidget {
  const MealsGrid({super.key, required this.meals, required this.onOpen});

  final List<MealEntity> meals;
  final ValueChanged<MealEntity> onOpen;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 600;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: meals.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
        childAspectRatio: isWide ? 0.95 : 0.66,
      ),
      itemBuilder: (context, index) {
        final meal = meals[index];
        return MealCardWidget(
          meal: meal,
          onTap: () => onOpen(meal),
          onAdd: () {
            context.read<CartCubit>().addMeal(meal);
            context.showSnack(context.l10n.addedToCart(meal.name));
          },
        );
      },
    );
  }
}
