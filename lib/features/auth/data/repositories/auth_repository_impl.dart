import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/services/firestore_service.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/firebase_auth_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._auth, this._firestore);

  final FirebaseAuthDataSource _auth;
  final FirestoreService _firestore;

  UserEntity _map(User user) => UserEntity(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
      );

  @override
  UserEntity? get currentUser {
    final user = _auth.currentUser;
    return user == null ? null : _map(user);
  }

  @override
  Stream<UserEntity?> get authChanges =>
      _auth.authChanges.map((user) => user == null ? null : _map(user));

  @override
  Future<UserEntity> signIn(String email, String password) async =>
      _map(await _auth.signIn(email, password));

  @override
  Future<UserEntity> signUp(String name, String email, String password) async {
    final user = await _auth.signUp(name, email, password);
    final model = UserModel.builder()
        .id(user.uid)
        .name(name.trim())
        .email(email.trim())
        .build();
    try {
      await _firestore.saveUser(model.id, model.toJson());
    } on Exception {
      // Best effort: the name is also stored on the auth profile, so the
      // account is still usable if this write fails.
    }
    return model;
  }

  @override
  Future<void> signOut() => _auth.signOut();
}
