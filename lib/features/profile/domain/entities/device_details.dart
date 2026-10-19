import 'package:equatable/equatable.dart';

class DeviceDetails extends Equatable {
  const DeviceDetails({
    required this.brand,
    required this.model,
    required this.osVersion,
  });

  final String brand;
  final String model;
  final String osVersion;

  @override
  List<Object?> get props => [brand, model, osVersion];
}
