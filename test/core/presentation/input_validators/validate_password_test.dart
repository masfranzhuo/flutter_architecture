import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failures/form_failure.dart';
import 'package:flutter_architecture/core/presentation/input_validators/validate_password.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ValidatePassword validatePassword;

  setUp(() {
    validatePassword = ValidatePassword();
  });

  group('ValidatePassword', () {
    test('should return PasswordLessThanCharactersFailure', () {
      final passwordTest = '12345';

      final result = validatePassword(Params(password: passwordTest));

      expect(result, Left(PasswordLessThanCharactersFailure()));
    });

    test('should return true', () {
      final passwordTest = '123456';

      final result = validatePassword(Params(password: passwordTest));

      expect(result, Right(true));
    });
  });

  group('Params Equatable', () {
    test('props are [password]', () {
      final passwordTest = '123456';
      expect(Params(password: passwordTest).props, [passwordTest]);
    });
  });
}
