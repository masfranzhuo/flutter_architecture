import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failure.dart';
import 'package:flutter_architecture/core/presentation/input_validators/validate_password.dart'
    hide Params;
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_change_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockValidatePassword extends Mock implements ValidatePassword {}

void main() {
  ValidateChangePassword validateChangePassword;
  MockValidatePassword mockValidatePassword;

  setUp(() {
    mockValidatePassword = MockValidatePassword();
    validateChangePassword = ValidateChangePassword(
      validatePassword: mockValidatePassword,
    );
  });

  void setUpValidatePasswordSuccess() {
    when(mockValidatePassword(any)).thenReturn(Right(true));
  }

  final currentPasswordTest = 'abcdef';

  test('should return PasswordLessThanCharactersFailure', () {
    final passwordTest = '1234';

    when(mockValidatePassword(any)).thenReturn(Left(
      PasswordLessThanCharactersFailure(),
    ));

    final result = validateChangePassword(Params(
      password: passwordTest,
      currentPassword: currentPasswordTest,
    ));

    verify(mockValidatePassword(any));
    expect(result, Left(PasswordLessThanCharactersFailure()));
  });

  test('should return PasswordAndCurrentPasswordMatchFailure', () {
    final passwordTest = 'abcdef';

    setUpValidatePasswordSuccess();

    final result = validateChangePassword(Params(
      password: passwordTest,
      currentPassword: currentPasswordTest,
    ));

    verify(mockValidatePassword(any));
    expect(result, Left(PasswordAndCurrentPasswordMatchFailure()));
  });

  test('should return true', () {
    final passwordTest = '123456';

    setUpValidatePasswordSuccess();

    final result = validateChangePassword(Params(
      password: passwordTest,
      currentPassword: currentPasswordTest,
    ));

    verify(mockValidatePassword(any));
    expect(result, Right(true));
  });
}
