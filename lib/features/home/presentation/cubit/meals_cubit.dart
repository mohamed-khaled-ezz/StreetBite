import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/utils/price_helper.dart';
import '../../domain/usecases/get_meals_usecase.dart';
import 'meals_state.dart';

class MealsCubit extends Cubit<MealsState> {
  MealsCubit(this._getMeals) : super(const MealsLoading());

  final GetMealsUseCase _getMeals;

  Future<void> load() async {
    emit(const MealsLoading());
    try {
      final list = await _getMeals();
      final featured = list.take(AppConstants.bannerCount).toList();
      final rawOffers =
          list.skip(AppConstants.bannerCount).take(AppConstants.hotOffersCount);
      final offers = rawOffers
          .map((m) => m.copyWith(price: PriceHelper.offerPrice(m.price)))
          .toList();

      emit(MealsLoaded(meals: list, featured: featured, offers: offers));
    } on AppFailure catch (e) {
      emit(MealsError(e));
    } catch (_) {
      emit(const MealsError(AppFailure(FailureType.unknown)));
    }
  }
}
