import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/failure_mapper.dart';

class FirebaseAuthDataSource {
  FirebaseAuthDataSource(this._auth);

  final FirebaseAuth _auth;

  /// Firebase restores the session on restart, which gives persistent login.
  User? get currentUser => _auth.currentUser;

  Stream<User?> get authChanges => _auth.authStateChanges();

  Future<User> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      throw FailureMapper.fromAuth(e);
    }
  }

  Future<User> signUp(String name, String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      await credential.user!.updateDisplayName(name.trim());
      await credential.user!.reload();
      return _auth.currentUser!;
    } on FirebaseAuthException catch (e) {
      throw FailureMapper.fromAuth(e);
    }
  }

  Future<void> signOut() => _auth.signOut();
}
