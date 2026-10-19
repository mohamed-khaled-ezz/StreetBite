import '../models/meal_model.dart';

/// Common contract for the remote and cached menu sources.
abstract class MealDataSource {
  Future<List<MealModel>> fetchMeals();
}
