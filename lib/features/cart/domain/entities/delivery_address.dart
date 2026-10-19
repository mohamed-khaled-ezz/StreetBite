import 'package:equatable/equatable.dart';

class DeliveryAddress extends Equatable {
  const DeliveryAddress({
    this.address = '',
    this.apartment = '',
    this.comment = '',
  });

  final String address;
  final String apartment;
  final String comment;

  bool get isEmpty => address.trim().isEmpty;

  String get formatted =>
      apartment.trim().isEmpty ? address : '$address, $apartment';

  @override
  List<Object?> get props => [address, apartment, comment];
}
