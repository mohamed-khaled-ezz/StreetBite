import '../../../../core/utils/price_helper.dart';
import '../../domain/entities/meal_entity.dart';

/// Maps TheMealDB JSON (and the same keys stored in the local cache/Firestore).
class MealModel extends MealEntity {
  const MealModel({
    required super.id,
    required super.name,
    required super.category,
    required super.area,
    required super.instructions,
    required super.thumbnail,
    required super.price,
  });

  /// [fallbackCategory] is used by the `filter.php` endpoint, whose items do
  /// not include a category.
  factory MealModel.fromJson(
    Map<String, dynamic> json, {
    String? fallbackCategory,
  }) {
    final id = (json['idMeal'] as String?) ?? '';
    return MealModel(
      id: id,
      name: (json['strMeal'] as String?) ?? '',
      category: (json['strCategory'] as String?) ?? fallbackCategory ?? '',
      area: (json['strArea'] as String?) ?? '',
      instructions: (json['strInstructions'] as String?) ?? '',
      thumbnail: (json['strMealThumb'] as String?) ?? '',
      price: PriceHelper.priceFor(id),
    );
  }

  factory MealModel.fromEntity(MealEntity meal) => MealModel(
        id: meal.id,
        name: meal.name,
        category: meal.category,
        area: meal.area,
        instructions: meal.instructions,
        thumbnail: meal.thumbnail,
        price: meal.price,
      );

  Map<String, dynamic> toJson() => {
        'idMeal': id,
        'strMeal': name,
        'strCategory': category,
        'strArea': area,
        'strInstructions': instructions,
        'strMealThumb': thumbnail,
      };
}
