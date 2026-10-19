import 'meal_model.dart';

/// Wraps {"meals": [...]} from TheMealDB API response.
class MealsResponse {
  const MealsResponse({required this.meals});

  final List<MealModel> meals;

  factory MealsResponse.fromJson(
    Map<String, dynamic> json, {
    String? fallbackCategory,
  }) {
    final list = (json['meals'] as List<dynamic>?) ?? [];
    return MealsResponse(
      meals: list
          .map((raw) => MealModel.fromJson(
                Map<String, dynamic>.from(raw as Map),
                fallbackCategory: fallbackCategory,
              ))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'meals': meals.map((m) => m.toJson()).toList(),
      };
}
