import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/app_failure.dart';
import '../../domain/entities/meal_entity.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/get_meal_by_id_usecase.dart';
import '../../domain/usecases/get_meals_by_category_usecase.dart';
import '../../domain/usecases/search_meals_usecase.dart';
import 'browse_state.dart';

class BrowseCubit extends Cubit<BrowseState> {
  BrowseCubit(
    this._getCategories,
    this._searchMeals,
    this._getMealsByCategory,
    this._getMealById,
  ) : super(const BrowseState());

  final GetCategoriesUseCase _getCategories;
  final SearchMealsUseCase _searchMeals;
  final GetMealsByCategoryUseCase _getMealsByCategory;
  final GetMealByIdUseCase _getMealById;

  Future<void> loadCategories() async {
    if (state.categories.isNotEmpty) return;
    emit(state.copyWith(status: BrowseStatus.loading));
    try {
      final list = await _getCategories();
      emit(state.copyWith(status: BrowseStatus.initial, categories: list));
    } on AppFailure catch (e) {
      emit(state.copyWith(status: BrowseStatus.error, failure: e.type));
    } catch (_) {
      emit(state.copyWith(
          status: BrowseStatus.error, failure: FailureType.unknown));
    }
  }

  Future<void> search(String query) async {
    if (query.trim().isEmpty) return clear();
    emit(state.copyWith(status: BrowseStatus.loading));
    try {
      final results = await _searchMeals(query);
      emit(state.copyWith(status: BrowseStatus.loaded, results: results));
    } on AppFailure catch (e) {
      emit(state.copyWith(status: BrowseStatus.error, failure: e.type));
    } catch (_) {
      emit(state.copyWith(
          status: BrowseStatus.error, failure: FailureType.unknown));
    }
  }

  Future<void> selectCategory(String category) async {
    emit(state.copyWith(status: BrowseStatus.loading));
    try {
      final results = await _getMealsByCategory(category);
      emit(state.copyWith(status: BrowseStatus.loaded, results: results));
    } on AppFailure catch (e) {
      emit(state.copyWith(status: BrowseStatus.error, failure: e.type));
    } catch (_) {
      emit(state.copyWith(
          status: BrowseStatus.error, failure: FailureType.unknown));
    }
  }

  /// Categories from `filter.php` lack instructions, so details screen fetches
  /// full details when required.
  Future<MealEntity> fullMeal(MealEntity meal) async {
    try {
      final full = await _getMealById(meal.id);
      return full ?? meal;
    } catch (_) {
      return meal;
    }
  }

  void clear() =>
      emit(state.copyWith(status: BrowseStatus.initial, results: []));
}
