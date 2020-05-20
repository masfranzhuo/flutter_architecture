import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failures/form_failure.dart';
import 'package:flutter_architecture/core/presentation/input_validators/validate_email.dart'
    hide Params;
import 'package:flutter_architecture/core/presentation/input_validators/validate_password.dart'
    hide Params;
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_register.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockValidateEmail extends Mock implements ValidateEmail {}

class MockValidatePassword extends Mock implements ValidatePassword {}

void main() {
  ValidateRegister validateRegister;
  MockValidateEmail mockValidateEmail;
  MockValidatePassword mockValidatePassword;

  setUp(() {
    mockValidateEmail = MockValidateEmail();
    mockValidatePassword = MockValidatePassword();
    validateRegister = ValidateRegister(
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

  test('should return NameLessThanCharactersFailure', () {
    final nameTest = 'Jo';

    final result = validateRegister(Params(
      name: nameTest,
    ));

    verifyZeroInteractions(mockValidateEmail);
    verifyZeroInteractions(mockValidatePassword);
    expect(result, Left(NameLessThanCharactersFailure()));
  });
  test('should return BadEmailFormatFailure', () {
    final nameTest = 'John Doe';
    final emailTest = 'johndoe.com';

    when(mockValidateEmail(any)).thenReturn(Left(BadEmailFormatFailure()));

    final result = validateRegister(Params(
      name: nameTest,
      email: emailTest,
    ));

    verify(mockValidateEmail(any));
    verifyZeroInteractions(mockValidatePassword);
    expect(result, Left(BadEmailFormatFailure()));
  });
  test('should return PasswordLessThanCharactersFailure', () {
    final nameTest = 'John Doe';
    final emailTest = 'john@doe.com';
    final passwordTest = '1234';

    setUpValidateEmailSuccess();
    when(mockValidatePassword(any))
        .thenReturn(Left(PasswordLessThanCharactersFailure()));

    final result = validateRegister(Params(
      name: nameTest,
      email: emailTest,
      password: passwordTest,
    ));

    verifyInOrder([mockValidateEmail(any), mockValidatePassword(any)]);
    expect(result, Left(PasswordLessThanCharactersFailure()));
  });
  test('should return PasswordAndRetypedMismatchFailure', () {
    final nameTest = 'John Doe';
    final emailTest = 'john@doe.com';
    final passwordTest = '123456';
    final retypedPasswordTest = '1234567';

    setUpValidateEmailSuccess();
    setUpValidatePasswordSuccess();

    final result = validateRegister(Params(
      name: nameTest,
      email: emailTest,
      password: passwordTest,
      retypedPassword: retypedPasswordTest,
    ));

    verifyInOrder([mockValidateEmail(any), mockValidatePassword(any)]);
    expect(result, Left(PasswordAndRetypedMismatchFailure()));
  });
  test('should return true', () {
    final nameTest = 'John Doe';
    final emailTest = 'john@doe.com';
    final passwordTest = '123456';
    final retypedPasswordTest = '123456';

    setUpValidateEmailSuccess();
    setUpValidatePasswordSuccess();

    final result = validateRegister(Params(
      name: nameTest,
      email: emailTest,
      password: passwordTest,
      retypedPassword: retypedPasswordTest,
    ));

    verifyInOrder([mockValidateEmail(any), mockValidatePassword(any)]);
    expect(result, Right(true));
  });
}
