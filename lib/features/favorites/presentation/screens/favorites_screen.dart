import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/network_meal_image.dart';
import '../../../home/domain/entities/meal_entity.dart';
import '../cubit/favorites_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<FavoritesCubit, List<MealEntity>>(
      builder: (context, favourites) {
        if (favourites.isEmpty) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.noFavourites),
          );
        }
        return Column(
          children: [
            for (final meal in favourites)
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () => Navigator.pushNamed(context, AppRoutes.details,
                    arguments: meal),
                leading: SizedBox(
                  width: 48,
                  height: 48,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: NetworkMealImage(url: meal.thumbnail, size: 'small'),
                  ),
                ),
                title: Text(meal.name),
                subtitle: Text(meal.category),
              ),
          ],
        );
      },
    );
  }
}
