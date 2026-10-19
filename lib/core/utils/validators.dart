import 'validation_error.dart';

/// Pure validation functions; they return an error type (or null when valid)
/// so the UI can localize the message.
class Validators {
  Validators._();

  static ValidationError? name(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return ValidationError.nameRequired;
    final first = text[0];
    if (first != first.toUpperCase() || first == first.toLowerCase()) {
      return ValidationError.nameCapital;
    }
    return null;
  }

  static ValidationError? email(String? value) {
    final text = value?.trim() ?? '';
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return regex.hasMatch(text) ? null : ValidationError.emailInvalid;
  }

  static ValidationError? password(String? value) {
    return (value ?? '').length >= 6 ? null : ValidationError.passwordShort;
  }

  static ValidationError? confirmPassword(String? value, String original) {
    return value == original ? null : ValidationError.passwordMismatch;
  }

  static ValidationError? required(String? value) {
    return (value ?? '').trim().isEmpty ? ValidationError.fieldRequired : null;
  }

  static ValidationError? cardNumber(String? value) {
    final digits = (value ?? '').replaceAll(' ', '');
    return RegExp(r'^\d{16}$').hasMatch(digits)
        ? null
        : ValidationError.cardInvalid;
  }
}
