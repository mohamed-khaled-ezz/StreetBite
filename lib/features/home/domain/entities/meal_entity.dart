import 'package:equatable/equatable.dart';

class MealEntity extends Equatable {
  const MealEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
    required this.price,
  });

  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;
  final double price;

  MealEntity copyWith({double? price, String? category}) {
    return MealEntity(
      id: id,
      name: name,
      category: category ?? this.category,
      area: area,
      instructions: instructions,
      thumbnail: thumbnail,
      price: price ?? this.price,
    );
  }

  @override
  List<Object?> get props => [id, name, category, area, thumbnail, price];
}
