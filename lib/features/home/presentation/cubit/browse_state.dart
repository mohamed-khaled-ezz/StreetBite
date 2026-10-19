import 'package:equatable/equatable.dart';

import '../../../../core/errors/app_failure.dart';
import '../../domain/entities/meal_entity.dart';

enum BrowseStatus { initial, loading, loaded, error }

class BrowseState extends Equatable {
  const BrowseState({
    this.status = BrowseStatus.initial,
    this.categories = const [],
    this.results = const [],
    this.failure,
  });

  final BrowseStatus status;
  final List<String> categories;
  final List<MealEntity> results;
  final FailureType? failure;

  BrowseState copyWith({
    BrowseStatus? status,
    List<String>? categories,
    List<MealEntity>? results,
    FailureType? failure,
  }) {
    return BrowseState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      results: results ?? this.results,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [status, categories, results, failure];
}
