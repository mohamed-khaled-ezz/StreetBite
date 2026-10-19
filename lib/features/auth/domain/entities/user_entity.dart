import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.photoBase64,
  });

  final String id;
  final String name;
  final String email;
  final String? photoBase64;

  @override
  List<Object?> get props => [id, name, email, photoBase64];
}
