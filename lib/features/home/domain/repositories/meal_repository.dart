import '../entities/meal_entity.dart';

abstract class MealRepository {
  Future<List<MealEntity>> getMeals();
  Future<List<MealEntity>> searchMeals(String query);
  Future<List<String>> getCategories();
  Future<List<MealEntity>> getMealsByCategory(String category);
  Future<MealEntity?> getMealById(String id);
}
