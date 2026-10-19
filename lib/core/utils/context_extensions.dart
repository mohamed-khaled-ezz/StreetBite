import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../errors/app_failure.dart';
import 'validation_error.dart';

extension ContextX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  void showSnack(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }
}

extension FailureText on FailureType {
  String localize(AppLocalizations l10n) {
    return switch (this) {
      FailureType.network => l10n.errorNetwork,
      FailureType.server => l10n.errorServer,
      FailureType.invalidCredentials => l10n.errorInvalidCredentials,
      FailureType.emailInUse => l10n.errorEmailInUse,
      FailureType.weakPassword => l10n.errorWeakPassword,
      FailureType.tooManyRequests => l10n.errorTooManyRequests,
      FailureType.payment => l10n.errorPayment,
      FailureType.unknown => l10n.errorUnknown,
    };
  }
}

extension ValidationText on ValidationError {
  String localize(AppLocalizations l10n) {
    return switch (this) {
      ValidationError.nameRequired => l10n.nameRequired,
      ValidationError.nameCapital => l10n.nameCapital,
      ValidationError.emailInvalid => l10n.emailInvalid,
      ValidationError.passwordShort => l10n.passwordShort,
      ValidationError.passwordMismatch => l10n.passwordMismatch,
      ValidationError.fieldRequired => l10n.fieldRequired,
      ValidationError.cardInvalid => l10n.cardInvalid,
    };
  }
}
