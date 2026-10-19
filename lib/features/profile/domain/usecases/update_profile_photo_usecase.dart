import '../repositories/profile_repository.dart';

class UpdateProfilePhotoUseCase {
  UpdateProfilePhotoUseCase(this._repository);
  final ProfileRepository _repository;

  Future<void> call(String uid, String photoBase64) =>
      _repository.updatePhoto(uid, photoBase64);
}
