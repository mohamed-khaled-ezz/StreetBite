import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../home/domain/entities/meal_entity.dart';
import '../../domain/usecases/set_favorite_usecase.dart';
import '../../domain/usecases/watch_favorites_usecase.dart';

class FavoritesCubit extends Cubit<List<MealEntity>> {
  FavoritesCubit(this._watch, this._setFavorite) : super(const []);

  final WatchFavoritesUseCase _watch;
  final SetFavoriteUseCase _setFavorite;
  StreamSubscription<List<MealEntity>>? _subscription;

  void watch(String uid) {
    _subscription?.cancel();
    _subscription = _watch(uid).listen(emit, onError: (_) {});
  }

  void stop() {
    _subscription?.cancel();
    emit(const []);
  }

  bool isFavourite(String mealId) => state.any((m) => m.id == mealId);

  /// Returns true when the Firestore write succeeded.
  Future<bool> toggle(String uid, MealEntity meal) async {
    try {
      await _setFavorite(uid, meal, isFavourite: !isFavourite(meal.id));
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
