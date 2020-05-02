import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failure.dart';
import 'package:flutter_architecture/core/presentation/input_validators/validate_email.dart'
    hide Params;
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_reset_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockValidateEmail extends Mock implements ValidateEmail {}

void main() {
  ValidateResetPassword validateResetPassword;
  MockValidateEmail mockValidateEmail;

  setUp(() {
    mockValidateEmail = MockValidateEmail();
    validateResetPassword = ValidateResetPassword(
      validateEmail: mockValidateEmail,
    );
  });

  test('should return BadEmailFormatFailure', () {
    final emailTest = 'john@doe';

    when(mockValidateEmail(any)).thenReturn(Left(BadEmailFormatFailure()));

    final result = validateResetPassword(Params(email: emailTest));

    verify(mockValidateEmail(any));
    expect(result, Left(BadEmailFormatFailure()));
  });

  test('should return true', () {
    final emailTest = 'john@doe.com';

    when(mockValidateEmail(any)).thenReturn(Right(true));

    final result = validateResetPassword(Params(email: emailTest));

    verify(mockValidateEmail(any));
    expect(result, Right(true));
  });
}
