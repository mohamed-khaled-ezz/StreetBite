import '../../../home/domain/entities/meal_entity.dart';
import '../../../profile/domain/repositories/profile_repository.dart';

class SetFavoriteUseCase {
  SetFavoriteUseCase(this._repository);
  final ProfileRepository _repository;

  Future<void> call(String uid, MealEntity meal, {required bool isFavourite}) =>
      _repository.setFavourite(uid, meal, isFavourite: isFavourite);
}
