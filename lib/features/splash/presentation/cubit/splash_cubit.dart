import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/repositories/auth_repository.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._authRepository) : super(const SplashInitial());

  final AuthRepository _authRepository;

  Future<void> init() async {
    await Future.delayed(const Duration(milliseconds: 2200));
    final user = _authRepository.currentUser;
    if (user != null) {
      emit(const SplashAuthenticated());
    } else {
      emit(const SplashUnauthenticated());
    }
  }
}
