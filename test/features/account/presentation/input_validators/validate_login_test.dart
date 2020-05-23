import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failures/form_failure.dart';
import 'package:flutter_architecture/core/presentation/input_validators/validate_email.dart'
    hide Params;
import 'package:flutter_architecture/core/presentation/input_validators/validate_password.dart'
    hide Params;
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockValidateEmail extends Mock implements ValidateEmail {}

class MockValidatePassword extends Mock implements ValidatePassword {}

void main() {
  ValidateLogin validateLogin;
  MockValidateEmail mockValidateEmail;
  MockValidatePassword mockValidatePassword;

  setUp(() {
    mockValidateEmail = MockValidateEmail();
    mockValidatePassword = MockValidatePassword();
    validateLogin = ValidateLogin(
      validateEmail: mockValidateEmail,
      validatePassword: mockValidatePassword,
    );
  });

  void setUpValidateEmailSuccess() {
    when(mockValidateEmail(any)).thenReturn(Right(true));
  }

  void setUpValidatePasswordSuccess() {
    when(mockValidatePassword(any)).thenReturn(Right(true));
  }

  test('should return BadEmailFormatFailure', () {
    final emailTest = 'john@doe';
    final passwordTest = '123456';

    when(mockValidateEmail(any)).thenReturn(Left(BadEmailFormatFailure()));

    final result = validateLogin(Params(
      email: emailTest,
      password: passwordTest,
    ));

    verify(mockValidateEmail(any));
    verifyZeroInteractions(mockValidatePassword);
    expect(result, Left(BadEmailFormatFailure()));
  });

  test('should return ', () {
    final emailTest = 'john@doe.com';
    final passwordTest = '1234';

    setUpValidateEmailSuccess();
    when(mockValidatePassword(any))
        .thenReturn(Left(PasswordLessThanCharactersFailure()));

    final result = validateLogin(Params(
      email: emailTest,
      password: passwordTest,
    ));

    verifyInOrder([mockValidateEmail(any), mockValidatePassword(any)]);
    expect(result, Left(PasswordLessThanCharactersFailure()));
  });

  test('should return true', () {
    final emailTest = 'john@doe.com';
    final passwordTest = '123456';

    setUpValidateEmailSuccess();
    setUpValidatePasswordSuccess();

    final result = validateLogin(Params(
      email: emailTest,
      password: passwordTest,
    ));

    verifyInOrder([mockValidateEmail(any), mockValidatePassword(any)]);
    expect(result, Right(true));
  });
}
