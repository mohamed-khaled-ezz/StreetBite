import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/errors/failure_mapper.dart';
import '../models/meal_model.dart';
import '../models/meals_response.dart';
import 'meal_datasource.dart';

/// Talks to TheMealDB (free test key) through Dio.
class MealRemoteDataSource implements MealDataSource {
  MealRemoteDataSource(this._dio);

  final Dio _dio;

  @override
  Future<List<MealModel>> fetchMeals() async {
    final results = await Future.wait(
      AppConstants.menuLetters
          .map((letter) => _meals('search.php', {'f': letter})),
    );
    final byId = <String, MealModel>{};
    for (final list in results) {
      for (final meal in list) {
        byId[meal.id] = meal;
      }
    }
    return byId.values.toList();
  }

  Future<List<MealModel>> search(String query) =>
      _meals('search.php', {'s': query});

  Future<List<String>> fetchCategories() async {
    final data = await _get('categories.php');
    final categories = (data['categories'] as List<dynamic>?) ?? [];
    return categories
        .map((raw) => (raw as Map)['strCategory'] as String)
        .toList();
  }

  Future<List<MealModel>> fetchByCategory(String category) =>
      _meals('filter.php', {'c': category}, fallbackCategory: category);

  Future<MealModel?> fetchById(String id) async {
    final meals = await _meals('lookup.php', {'i': id});
    return meals.isEmpty ? null : meals.first;
  }

  Future<List<MealModel>> _meals(
    String path,
    Map<String, dynamic> params, {
    String? fallbackCategory,
  }) async {
    final data = await _get(path, params);
    return MealsResponse.fromJson(data, fallbackCategory: fallbackCategory)
        .meals;
  }

  Future<Map<String, dynamic>> _get(
    String path, [
    Map<String, dynamic>? params,
  ]) async {
    try {
      final response = await _dio.get<dynamic>(path, queryParameters: params);
      final body = response.data;
      final decoded = body is String ? jsonDecode(body) : body;
      return Map<String, dynamic>.from(decoded as Map);
    } on DioException catch (e) {
      throw FailureMapper.fromDio(e);
    } on FormatException {
      throw const AppFailure(FailureType.server);
    }
  }
}
