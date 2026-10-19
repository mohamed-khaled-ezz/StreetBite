import 'package:flutter_test/flutter_test.dart';
import 'package:streetbite/core/utils/validation_error.dart';
import 'package:streetbite/core/utils/validators.dart';

void main() {
  test('name must start with a capital letter', () {
    expect(Validators.name('ahmed'), ValidationError.nameCapital);
    expect(Validators.name('Ahmed Ali'), isNull);
  });

  test('password needs at least six characters', () {
    expect(Validators.password('12345'), ValidationError.passwordShort);
    expect(Validators.password('123456'), isNull);
  });

  test('confirm password must match', () {
    expect(
        Validators.confirmPassword('a', 'b'), ValidationError.passwordMismatch);
    expect(Validators.confirmPassword('abc123', 'abc123'), isNull);
  });
}
