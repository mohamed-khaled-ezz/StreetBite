import '../../../../core/errors/app_failure.dart';
import 'payment_method.dart';

/// Card payment validates the card before the order is accepted.
/// New payment types can be added without touching existing classes (Open/Closed).
class CardPayment implements PaymentMethod {
  CardPayment({required this.cardNumber});

  final String cardNumber;

  @override
  String get id => 'card';

  @override
  Future<void> pay(double amount) async {
    final digits = cardNumber.replaceAll(' ', '');
    if (!RegExp(r'^\d{16}$').hasMatch(digits)) {
      throw const AppFailure(FailureType.payment);
    }
  }
}
