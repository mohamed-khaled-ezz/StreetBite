import 'package:equatable/equatable.dart';

import '../../../../core/errors/app_failure.dart';
import '../../domain/entities/meal_entity.dart';

sealed class MealsState extends Equatable {
  const MealsState();

  @override
  List<Object?> get props => [];
}

class MealsLoading extends MealsState {
  const MealsLoading();
}

class MealsLoaded extends MealsState {
  const MealsLoaded({
    required this.meals,
    required this.featured,
    required this.offers,
  });

  final List<MealEntity> meals;
  final List<MealEntity> featured;
  final List<MealEntity> offers;

  @override
  List<Object?> get props => [meals, featured, offers];
}

class MealsError extends MealsState {
  const MealsError(this.failure);

  final AppFailure failure;

  @override
  List<Object?> get props => [failure];
}
