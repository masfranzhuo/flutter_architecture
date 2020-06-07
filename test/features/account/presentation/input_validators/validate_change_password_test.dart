import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failures/form_failure.dart';
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

  test('should return FieldEmptyFailure', () {
    final passwordTest = '123456';
    final retypedPasswordTest = '123456';

    final result = validateChangePassword(Params(
      password: passwordTest,
      retypedPassword: retypedPasswordTest,
      currentPassword: '',
    ));

    expect(result, Left(FieldEmptyFailure()));
  });

  test('should return PasswordLessThanCharactersFailure', () {
    final passwordTest = '1234';
    final retypedPasswordTest = '123456';

    when(mockValidatePassword(any)).thenReturn(Left(
      PasswordLessThanCharactersFailure(),
    ));

    final result = validateChangePassword(Params(
      password: passwordTest,
      retypedPassword: retypedPasswordTest,
      currentPassword: currentPasswordTest,
    ));

    verify(mockValidatePassword(any));
    expect(result, Left(PasswordLessThanCharactersFailure()));
  });

  test('should return PasswordAndCurrentPasswordMatchFailure', () {
    final passwordTest = 'abcdef';
    final retypedPasswordTest = passwordTest;

    setUpValidatePasswordSuccess();

    final result = validateChangePassword(Params(
      password: passwordTest,
      retypedPassword: retypedPasswordTest,
      currentPassword: currentPasswordTest,
    ));

    verify(mockValidatePassword(any));
    expect(result, Left(PasswordAndCurrentPasswordMatchFailure()));
  });

  test('should return PasswordAndRetypedMismatchFailure', () {
    final passwordTest = '123456';
    final retypedPasswordTest = '1234567';

    setUpValidatePasswordSuccess();

    final result = validateChangePassword(Params(
      password: passwordTest,
      retypedPassword: retypedPasswordTest,
      currentPassword: currentPasswordTest,
    ));

    verify(mockValidatePassword(any));
    expect(result, Left(PasswordAndRetypedMismatchFailure()));
  });

  test('should return true', () {
    final passwordTest = '123456';
    final retypedPasswordTest = passwordTest;

    setUpValidatePasswordSuccess();

    final result = validateChangePassword(Params(
      password: passwordTest,
      retypedPassword: retypedPasswordTest,
      currentPassword: currentPasswordTest,
    ));

    verify(mockValidatePassword(any));
    expect(result, Right(true));
  });
}
