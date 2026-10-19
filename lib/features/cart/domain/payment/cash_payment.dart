import 'payment_method.dart';

/// Cash is collected on delivery, so there is nothing to process now.
class CashPayment implements PaymentMethod {
  @override
  String get id => 'cash';

  @override
  Future<void> pay(double amount) async {}
}
