import '../entities/meal_entity.dart';
import '../repositories/meal_repository.dart';

class SearchMealsUseCase {
  SearchMealsUseCase(this._repository);
  final MealRepository _repository;

  Future<List<MealEntity>> call(String query) => _repository.searchMeals(query);
}
