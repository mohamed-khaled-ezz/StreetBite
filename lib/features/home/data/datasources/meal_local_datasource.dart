import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../models/meal_model.dart';
import 'meal_datasource.dart';

/// Menu cache stored in shared_preferences, restored after an app restart.
class MealLocalDataSource implements MealDataSource {
  MealLocalDataSource(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<List<MealModel>> fetchMeals() async {
    final raw = _prefs.getString(AppConstants.mealsCacheKey);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => MealModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  Future<void> cacheMeals(List<MealModel> meals) {
    final json = jsonEncode(meals.map((m) => m.toJson()).toList());
    return _prefs.setString(AppConstants.mealsCacheKey, json);
  }
}
