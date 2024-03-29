import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failures/form_failure.dart';
import 'package:flutter_architecture/core/presentation/input_validators/validate_email.dart'
    hide Params;
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_forget_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockValidateEmail extends Mock implements ValidateEmail {}

void main() {
  ValidateForgetPassword validateForgetPassword;
  MockValidateEmail mockValidateEmail;

  setUp(() {
    mockValidateEmail = MockValidateEmail();
    validateForgetPassword = ValidateForgetPassword(
      validateEmail: mockValidateEmail,
    );
  });

  test('should return BadEmailFormatFailure', () {
    final emailTest = 'john@doe';

    when(mockValidateEmail(any)).thenReturn(Left(BadEmailFormatFailure()));

    final result = validateForgetPassword(Params(email: emailTest));

    verify(mockValidateEmail(any));
    expect(result, Left(BadEmailFormatFailure()));
  });

  test('should return true', () {
    final emailTest = 'john@doe.com';

    when(mockValidateEmail(any)).thenReturn(Right(true));

    final result = validateForgetPassword(Params(email: emailTest));

    verify(mockValidateEmail(any));
    expect(result, Right(true));
  });
}
