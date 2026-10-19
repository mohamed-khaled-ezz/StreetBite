import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../data/datasources/device_info_datasource.dart';
import '../../domain/usecases/update_profile_photo_usecase.dart';
import '../../domain/usecases/watch_profile_usecase.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._watch, this._updatePhoto, this._deviceInfo)
      : super(const ProfileState());

  final WatchProfileUseCase _watch;
  final UpdateProfilePhotoUseCase _updatePhoto;
  final DeviceInfoDataSource _deviceInfo;
  StreamSubscription<UserEntity?>? _subscription;

  Future<void> watch(String uid) async {
    _subscription?.cancel();
    _subscription = _watch(uid).listen((user) {
      if (user != null) emit(state.copyWith(user: user));
    }, onError: (_) {});
    try {
      emit(state.copyWith(device: await _deviceInfo.load()));
    } catch (_) {
      // Device details are informational; ignore failures.
    }
  }

  void stop() {
    _subscription?.cancel();
    emit(const ProfileState());
  }

  /// Updates the UI immediately, then uploads to Firestore.
  /// Returns true when the upload succeeded.
  Future<bool> changePhoto(UserEntity current, String photoBase64) async {
    emit(state.copyWith(
      user: UserEntity(
        id: current.id,
        name: current.name,
        email: current.email,
        photoBase64: photoBase64,
      ),
    ));
    try {
      await _updatePhoto(current.id, photoBase64);
      return true;
    } on AppFailure {
      return false;
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
