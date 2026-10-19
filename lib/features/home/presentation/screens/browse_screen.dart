import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/widgets/category_tile.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../domain/entities/meal_entity.dart';
import '../cubit/browse_cubit.dart';
import '../cubit/browse_state.dart';
import '../widgets/meals_grid.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<BrowseCubit>().loadCategories();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _open(MealEntity meal) async {
    final full = meal.instructions.isEmpty
        ? await context.read<BrowseCubit>().fullMeal(meal)
        : meal;
    if (!mounted) return;
    Navigator.pushNamed(context, AppRoutes.details, arguments: full);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<BrowseCubit>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.search,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 12),
            TextField(
              controller: _search,
              textInputAction: TextInputAction.search,
              onSubmitted: cubit.search,
              decoration: InputDecoration(
                hintText: l10n.searchHint,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _search.clear();
                    cubit.clear();
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<BrowseCubit, BrowseState>(
                builder: (context, state) {
                  if (state.status == BrowseStatus.loading) {
                    return const LoadingView();
                  }
                  if (state.status == BrowseStatus.error) {
                    return ErrorView(
                      message: state.failure!.localize(l10n),
                      onRetry: cubit.loadCategories,
                    );
                  }
                  if (state.status == BrowseStatus.loaded) {
                    return state.results.isEmpty
                        ? Center(child: Text(l10n.noResults))
                        : SingleChildScrollView(
                            child:
                                MealsGrid(meals: state.results, onOpen: _open),
                          );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.categories,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 12),
                      Expanded(
                        child: GridView.builder(
                          itemCount: state.categories.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 1.7,
                          ),
                          itemBuilder: (context, i) => CategoryTile(
                            label: state.categories[i],
                            onTap: () {
                              _search.clear();
                              cubit.selectCategory(state.categories[i]);
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
