// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'StreetBite';

  @override
  String get welcomeTitle => 'Food and groceries delivered to you';

  @override
  String get welcomeSubtitle => 'Sign in or create an account to get started';

  @override
  String get continueLabel => 'Continue';

  @override
  String get login => 'Log in';

  @override
  String get signUp => 'Sign up';

  @override
  String get createAccount => 'Create account';

  @override
  String get fullName => 'Full name';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get noAccountPrompt => 'Don\'t have an account?';

  @override
  String get haveAccountPrompt => 'Already have an account?';

  @override
  String get signOut => 'Sign out';

  @override
  String get nameRequired => 'Please enter your full name';

  @override
  String get nameCapital => 'Name must start with a capital letter';

  @override
  String get emailInvalid => 'Enter a valid email address';

  @override
  String get passwordShort => 'Password must be at least 6 characters';

  @override
  String get passwordMismatch => 'Passwords do not match';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get cardInvalid => 'Enter a valid 16-digit card number';

  @override
  String get errorNetwork => 'No internet connection. Please try again.';

  @override
  String get errorServer =>
      'Something went wrong on our side. Please try again later.';

  @override
  String get errorInvalidCredentials => 'Incorrect email or password.';

  @override
  String get errorEmailInUse => 'This email is already registered.';

  @override
  String get errorWeakPassword => 'This password is too weak.';

  @override
  String get errorTooManyRequests =>
      'Too many attempts. Please wait and try again.';

  @override
  String get errorPayment => 'Payment failed. Please check your card details.';

  @override
  String get errorUnknown => 'Something went wrong. Please try again.';

  @override
  String get retry => 'Retry';

  @override
  String get home => 'Home';

  @override
  String get browse => 'Browse';

  @override
  String get orders => 'Orders';

  @override
  String get profile => 'Profile';

  @override
  String get search => 'Search';

  @override
  String get searchHint => 'Search meals';

  @override
  String get categories => 'Categories';

  @override
  String get noResults => 'No meals found';

  @override
  String get featured => 'Featured';

  @override
  String get hotOffers => 'Hot offers';

  @override
  String get recommended => 'Recommended';

  @override
  String get addToCart => 'Add to cart';

  @override
  String addedToCart(String name) {
    return '$name added to cart';
  }

  @override
  String addAnother(int count) {
    return 'Add another ($count in cart)';
  }

  @override
  String discountBadge(String percent) {
    return '$percent% off';
  }

  @override
  String priceLabel(String amount) {
    return '$amount EGP';
  }

  @override
  String get category => 'Category';

  @override
  String get origin => 'Origin';

  @override
  String get instructions => 'Instructions';

  @override
  String get favourites => 'Favourites';

  @override
  String get favouriteAdded => 'Saved to favourites';

  @override
  String get favouriteRemoved => 'Removed from favourites';

  @override
  String get noFavourites => 'No favourites yet';

  @override
  String get order => 'Order';

  @override
  String get delivery => 'Delivery';

  @override
  String get pickup => 'Pickup';

  @override
  String get emptyCart => 'Your cart is empty';

  @override
  String get cartBecameEmpty => 'Your cart is now empty';

  @override
  String get remove => 'Remove';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get deliveryFee => 'Delivery fee';

  @override
  String get serviceFee => 'Fees & taxes';

  @override
  String get total => 'Total';

  @override
  String get checkout => 'Checkout';

  @override
  String get deliveryTime => 'Delivery time';

  @override
  String get express => 'Express';

  @override
  String get standard => 'Standard';

  @override
  String minutesRange(String range) {
    return '$range min';
  }

  @override
  String get deliveryAddress => 'Delivery address';

  @override
  String get addAddress => 'Add delivery address';

  @override
  String get address => 'Address';

  @override
  String get apartment => 'Apartment';

  @override
  String get comment => 'Comment';

  @override
  String get save => 'Save';

  @override
  String get paymentMethod => 'Payment method';

  @override
  String get cash => 'Cash';

  @override
  String get card => 'Card';

  @override
  String get addCard => 'Add card';

  @override
  String get cardNumber => 'Card number';

  @override
  String get cardName => 'Name on card';

  @override
  String get expiry => 'Exp';

  @override
  String get cvv => 'CVV';

  @override
  String get zip => 'Zip';

  @override
  String get defaultPaymentMethod => 'Default payment method';

  @override
  String get placeOrder => 'Place order';

  @override
  String get orderPlaced => 'Order placed successfully';

  @override
  String get ordersEmpty => 'No orders yet';

  @override
  String get pastOrders => 'Past';

  @override
  String get orderHistory => 'Order history';

  @override
  String orderNumber(String id) {
    return 'Order #$id';
  }

  @override
  String itemsCount(int count) {
    return '$count items';
  }

  @override
  String arrivesIn(String range) {
    return 'Arrives in $range min';
  }

  @override
  String get preparingOrder => 'Preparing your order';

  @override
  String get stepReceived => 'Order received';

  @override
  String get stepCooking => 'Cooking your order';

  @override
  String get stepCourier => 'Looking for courier';

  @override
  String get stepDelivered => 'Order delivered';

  @override
  String get deviceDetails => 'Device details';

  @override
  String get deviceBrand => 'Brand';

  @override
  String get deviceModel => 'Model';

  @override
  String get deviceOs => 'OS version';

  @override
  String get changePhoto => 'Change photo';

  @override
  String get photoUpdated => 'Profile photo updated';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get arabic => 'العربية';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get contactUs => 'Contact us';

  @override
  String get helpCenter => 'Help center';

  @override
  String get contactInfo => 'Email us at support@streetbite.app';

  @override
  String get helpInfo =>
      'Browse meals, add them to your cart, then check out from the cart screen.';

  @override
  String get close => 'Close';
}
