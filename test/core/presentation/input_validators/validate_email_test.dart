import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failures/form_failure.dart';
import 'package:flutter_architecture/core/presentation/input_validators/validate_email.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ValidateEmail validateEmail;

  setUp(() {
    validateEmail = ValidateEmail();
  });

  group('ValidateEmail call', () {
    test('should return BadEmailFormatFailure', () {
      final emailTest = 'email';

      final result = validateEmail(Params(email: emailTest));

      expect(result, Left(BadEmailFormatFailure()));
    });

    test('should return BadEmailFormatFailure', () {
      final emailTest = 'email.com';

      final result = validateEmail(Params(email: emailTest));

      expect(result, Left(BadEmailFormatFailure()));
    });

    test('should return BadEmailFormatFailure', () {
      final emailTest = 'email@email';

      final result = validateEmail(Params(email: emailTest));

      expect(result, Left(BadEmailFormatFailure()));
    });

    test('should return true', () {
      final emailTest = 'email@email.com';

      final result = validateEmail(Params(email: emailTest));

      expect(result, Right(true));
    });
  });

  group('Params Equatable', () {
    test('props are [email]', () {
      final emailTest = 'email@email.com';
      expect(Params(email: emailTest).props, [emailTest]);
    });
  });
}
