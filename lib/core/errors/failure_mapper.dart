import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'app_failure.dart';

/// Converts low-level exceptions (Dio, Firebase) into [AppFailure].
class FailureMapper {
  FailureMapper._();

  static AppFailure fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const AppFailure(FailureType.network);
      default:
        return const AppFailure(FailureType.server);
    }
  }

  static AppFailure fromAuth(FirebaseAuthException e) {
    return switch (e.code) {
      'invalid-credential' ||
      'wrong-password' ||
      'user-not-found' ||
      'invalid-email' =>
        const AppFailure(FailureType.invalidCredentials),
      'email-already-in-use' => const AppFailure(FailureType.emailInUse),
      'weak-password' => const AppFailure(FailureType.weakPassword),
      'network-request-failed' => const AppFailure(FailureType.network),
      'too-many-requests' => const AppFailure(FailureType.tooManyRequests),
      _ => const AppFailure(FailureType.unknown),
    };
  }

  static AppFailure fromFirestore(FirebaseException e) {
    return e.code == 'unavailable'
        ? const AppFailure(FailureType.network)
        : const AppFailure(FailureType.server);
  }
}
