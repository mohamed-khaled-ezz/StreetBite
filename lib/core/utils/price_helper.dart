import '../constants/app_constants.dart';

/// TheMealDB has no prices, so a stable price is derived from the meal id.
class PriceHelper {
  PriceHelper._();

  static double priceFor(String mealId) {
    final number = int.tryParse(mealId) ?? 0;
    return 40 + (number % 60) + 0.99;
  }

  static double offerPrice(double price) =>
      price * (1 - AppConstants.offerDiscount);
}
