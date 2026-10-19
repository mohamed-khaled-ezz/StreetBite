import '../repositories/meal_repository.dart';

class GetCategoriesUseCase {
  GetCategoriesUseCase(this._repository);
  final MealRepository _repository;

  Future<List<String>> call() => _repository.getCategories();
}
