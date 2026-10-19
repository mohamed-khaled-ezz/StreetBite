import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../domain/entities/meal_entity.dart';
import '../cubit/meals_cubit.dart';
import '../cubit/meals_state.dart';
import '../widgets/featured_banner_widget.dart';
import '../widgets/home_header.dart';
import '../widgets/hot_offers_widget.dart';
import '../widgets/meals_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _open(BuildContext context, MealEntity meal) =>
      Navigator.pushNamed(context, AppRoutes.details, arguments: meal);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final width = MediaQuery.sizeOf(context).width;
    final padding = width >= 600 ? 32.0 : 16.0;
    final titleStyle = Theme.of(context)
        .textTheme
        .titleLarge
        ?.copyWith(fontWeight: FontWeight.w800);

    return SafeArea(
      child: BlocBuilder<MealsCubit, MealsState>(
        builder: (context, state) {
          return switch (state) {
            MealsLoading() => const LoadingView(),
            MealsError(:final failure) => ErrorView(
                message: failure.type.localize(l10n),
                onRetry: () => context.read<MealsCubit>().load(),
              ),
            MealsLoaded() => RefreshIndicator(
                onRefresh: () => context.read<MealsCubit>().load(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HomeHeader(),
                      const SizedBox(height: 16),
                      Text(l10n.featured, style: titleStyle),
                      const SizedBox(height: 12),
                      FeaturedBannerWidget(
                        meals: state.featured,
                        height: width * (width >= 600 ? 0.3 : 0.5),
                        onOpen: (meal) => _open(context, meal),
                      ),
                      const SizedBox(height: 24),
                      Text(l10n.hotOffers, style: titleStyle),
                      const SizedBox(height: 12),
                      HotOffersWidget(
                        offers: state.offers,
                        onOpen: (meal) => _open(context, meal),
                      ),
                      const SizedBox(height: 24),
                      Text(l10n.recommended, style: titleStyle),
                      const SizedBox(height: 12),
                      MealsGrid(
                        meals: state.meals,
                        onOpen: (meal) => _open(context, meal),
                      ),
                    ],
                  ),
                ),
              ),
          };
        },
      ),
    );
  }
}
