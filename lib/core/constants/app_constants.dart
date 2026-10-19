/// Central place for non-UI constants (no user-visible text lives here).
class AppConstants {
  AppConstants._();

  /// TheMealDB free tier: the public test key "1" is part of the URL.
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1/';

  /// The free API has no "list all" endpoint, so the menu is built from
  /// several first-letter searches that run in parallel.
  static const List<String> menuLetters = ['a', 'b', 'c', 'm', 's'];

  static const int hotOffersCount = 5;
  static const int bannerCount = 5;
  static const double offerDiscount = 0.2;
  static const double deliveryFee = 15;
  static const double serviceFee = 5;

  static const String mealsCacheKey = 'cached_meals';
  static const String themeKey = 'theme_dark';
  static const String localeKey = 'locale_code';
  static const String addressKey = 'delivery_address';
  static const String apartmentKey = 'delivery_apartment';
  static const String commentKey = 'delivery_comment';
}
