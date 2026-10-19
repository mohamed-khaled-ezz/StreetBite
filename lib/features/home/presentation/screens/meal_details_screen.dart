import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/network_meal_image.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../cart/presentation/cubit/cart_state.dart';
import '../../../cart/presentation/widgets/cart_icon_button.dart';
import '../../../favorites/presentation/cubit/favorites_cubit.dart';
import '../../domain/entities/meal_entity.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final MealEntity meal;

  Future<void> _toggleFavourite(BuildContext context) async {
    final uid = context.read<AuthCubit>().userId;
    if (uid == null) return;
    final cubit = context.read<FavoritesCubit>();
    final wasFavourite = cubit.isFavourite(meal.id);
    final ok = await cubit.toggle(uid, meal);
    if (!context.mounted) return;
    final l10n = context.l10n;
    context.showSnack(ok
        ? (wasFavourite ? l10n.favouriteRemoved : l10n.favouriteAdded)
        : l10n.errorServer);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    // BlocConsumer: the listener gives feedback, the builder keeps the cart
    // quantity live.
    return BlocConsumer<CartCubit, CartState>(
      listenWhen: (prev, curr) =>
          curr.quantityOf(meal.id) > prev.quantityOf(meal.id),
      listener: (context, state) =>
          context.showSnack(l10n.addedToCart(meal.name)),
      builder: (context, state) {
        final quantity = state.quantityOf(meal.id);
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 300,
                actions: [
                  BlocBuilder<FavoritesCubit, List<MealEntity>>(
                    builder: (context, favourites) {
                      final isFav = favourites.any((m) => m.id == meal.id);
                      return IconButton.filledTonal(
                        tooltip: l10n.favourites,
                        onPressed: () => _toggleFavourite(context),
                        icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border),
                      );
                    },
                  ),
                  const CartIconButton(),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background:
                      NetworkMealImage(url: meal.thumbnail, size: 'large'),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(meal.name,
                          style: theme.textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          Chip(
                              label:
                                  Text('${l10n.category}: ${meal.category}')),
                          if (meal.area.isNotEmpty)
                            Chip(label: Text('${l10n.origin}: ${meal.area}')),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(l10n.priceLabel(meal.price.toStringAsFixed(2)),
                          style: theme.textTheme.titleLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w800)),
                      const SizedBox(height: 16),
                      Text(l10n.instructions,
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      Text(meal.instructions),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: PrimaryButton(
                label:
                    quantity == 0 ? l10n.addToCart : l10n.addAnother(quantity),
                onPressed: () => context.read<CartCubit>().addMeal(meal),
              ),
            ),
          ),
        );
      },
    );
  }
}
