import '../../domain/entities/user_entity.dart';
import 'user_model_builder.dart';

class UserModel extends UserEntity {
  const UserModel.internal({
    required super.id,
    required super.name,
    required super.email,
    super.photoBase64,
  });

  /// Entry point of the Builder pattern (see [UserModelBuilder]).
  static UserModelBuilder builder() => UserModelBuilder();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel.builder()
        .id((json['id'] as String?) ?? '')
        .name((json['name'] as String?) ?? '')
        .email((json['email'] as String?) ?? '')
        .photoBase64(json['photoBase64'] as String?)
        .build();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'photoBase64': photoBase64,
      };
}
