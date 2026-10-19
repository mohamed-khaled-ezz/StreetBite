import '../../../../core/errors/app_failure.dart';
import '../../domain/entities/meal_entity.dart';
import '../../domain/repositories/meal_repository.dart';
import '../datasources/meal_datasource_factory.dart';
import '../datasources/meal_local_datasource.dart';
import '../datasources/meal_remote_datasource.dart';

class MealRepositoryImpl implements MealRepository {
  MealRepositoryImpl(this._factory, this._remote, this._local);

  final MealDataSourceFactory _factory;
  final MealRemoteDataSource _remote;
  final MealLocalDataSource _local;

  /// Tries the live API first and refreshes the cache; if the API fails the
  /// cached menu (restored from shared_preferences) is used instead.
  @override
  Future<List<MealEntity>> getMeals() async {
    try {
      final meals = await _factory.create(MealSource.remote).fetchMeals();
      if (meals.isNotEmpty) {
        await _local.cacheMeals(meals);
        return meals;
      }
    } on AppFailure {
      final cached = await _factory.create(MealSource.cached).fetchMeals();
      if (cached.isEmpty) rethrow;
      return cached;
    }
    final cached = await _factory.create(MealSource.cached).fetchMeals();
    if (cached.isEmpty) throw const AppFailure(FailureType.server);
    return cached;
  }

  @override
  Future<List<MealEntity>> searchMeals(String query) => _remote.search(query);

  @override
  Future<List<String>> getCategories() => _remote.fetchCategories();

  @override
  Future<List<MealEntity>> getMealsByCategory(String category) =>
      _remote.fetchByCategory(category);

  @override
  Future<MealEntity?> getMealById(String id) => _remote.fetchById(id);
}
