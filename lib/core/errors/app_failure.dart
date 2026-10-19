/// Every error shown to the user is reduced to one of these types, so the UI
/// can map it to a localized, friendly message.
enum FailureType {
  network,
  server,
  invalidCredentials,
  emailInUse,
  weakPassword,
  tooManyRequests,
  payment,
  unknown,
}

class AppFailure implements Exception {
  const AppFailure(this.type);

  final FailureType type;
}
