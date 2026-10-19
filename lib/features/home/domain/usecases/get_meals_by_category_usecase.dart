import '../entities/meal_entity.dart';
import '../repositories/meal_repository.dart';

class GetMealsByCategoryUseCase {
  GetMealsByCategoryUseCase(this._repository);
  final MealRepository _repository;

  Future<List<MealEntity>> call(String category) =>
      _repository.getMealsByCategory(category);
}
