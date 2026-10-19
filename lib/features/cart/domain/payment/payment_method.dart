/// SOLID (Interface Segregation + Dependency Inversion): the cart only depends
/// on this abstraction, never on a concrete payment type.
abstract class PaymentMethod {
  String get id;

  /// Completes the payment or throws an [AppFailure] of type payment.
  Future<void> pay(double amount);
}
