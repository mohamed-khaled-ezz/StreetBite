import 'package:equatable/equatable.dart';

import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/entities/device_details.dart';

class ProfileState extends Equatable {
  const ProfileState({this.user, this.device});

  final UserEntity? user;
  final DeviceDetails? device;

  ProfileState copyWith({UserEntity? user, DeviceDetails? device}) =>
      ProfileState(user: user ?? this.user, device: device ?? this.device);

  @override
  List<Object?> get props => [user, device];
}
