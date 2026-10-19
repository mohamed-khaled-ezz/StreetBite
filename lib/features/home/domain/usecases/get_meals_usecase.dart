import '../entities/meal_entity.dart';
import '../repositories/meal_repository.dart';

class GetMealsUseCase {
  GetMealsUseCase(this._repository);
  final MealRepository _repository;

  Future<List<MealEntity>> call() => _repository.getMeals();
}
