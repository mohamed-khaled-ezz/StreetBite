import '../../../home/domain/entities/meal_entity.dart';
import '../../../profile/domain/repositories/profile_repository.dart';

class WatchFavoritesUseCase {
  WatchFavoritesUseCase(this._repository);
  final ProfileRepository _repository;

  Stream<List<MealEntity>> call(String uid) => _repository.watchFavourites(uid);
}
