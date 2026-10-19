import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  SignUpUseCase(this._repository);
  final AuthRepository _repository;

  Future<UserEntity> call(String name, String email, String password) =>
      _repository.signUp(name, email, password);
}
