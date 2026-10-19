import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/app_failure.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._repository,
    this._loginUseCase,
    this._signUpUseCase,
    this._logoutUseCase,
  ) : super(_initial(_repository)) {
    // Detects sign-outs that happen outside this cubit (e.g. expired session).
    _subscription = _repository.authChanges.listen((user) {
      if (user == null && state is Authenticated) emit(const Unauthenticated());
    });
  }

  final AuthRepository _repository;
  final LoginUseCase _loginUseCase;
  final SignUpUseCase _signUpUseCase;
  final LogoutUseCase _logoutUseCase;
  StreamSubscription<dynamic>? _subscription;

  /// Firebase persists the session, so a restart starts already signed in.
  static AuthState _initial(AuthRepository repository) {
    final user = repository.currentUser;
    return user == null ? const Unauthenticated() : Authenticated(user);
  }

  String? get userId {
    final current = state;
    return current is Authenticated ? current.user.id : null;
  }

  Future<void> signIn(String email, String password) =>
      _run(() => _loginUseCase(email, password));

  Future<void> signUp(String name, String email, String password) =>
      _run(() => _signUpUseCase(name, email, password));

  Future<void> signOut() async {
    await _logoutUseCase();
    emit(const Unauthenticated());
  }

  Future<void> _run(Future<dynamic> Function() action) async {
    emit(const AuthLoading());
    try {
      final user = await action();
      emit(Authenticated(user));
    } on AppFailure catch (e) {
      emit(AuthFailure(e.type));
    } catch (_) {
      emit(const AuthFailure(FailureType.unknown));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
