import '../../../auth/domain/entities/user_entity.dart';
import '../repositories/profile_repository.dart';

class WatchProfileUseCase {
  WatchProfileUseCase(this._repository);
  final ProfileRepository _repository;

  Stream<UserEntity?> call(String uid) => _repository.watchProfile(uid);
}
