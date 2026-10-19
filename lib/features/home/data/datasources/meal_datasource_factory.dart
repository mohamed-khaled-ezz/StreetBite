import 'meal_datasource.dart';
import 'meal_local_datasource.dart';
import 'meal_remote_datasource.dart';

enum MealSource { remote, cached }

/// FACTORY PATTERN: [MealRepositoryImpl] asks this factory for a data source
/// instead of creating one, so choosing remote vs cached data stays in one place.
class MealDataSourceFactory {
  MealDataSourceFactory(this._remote, this._local);

  final MealRemoteDataSource _remote;
  final MealLocalDataSource _local;

  MealDataSource create(MealSource source) {
    return switch (source) {
      MealSource.remote => _remote,
      MealSource.cached => _local,
    };
  }
}
