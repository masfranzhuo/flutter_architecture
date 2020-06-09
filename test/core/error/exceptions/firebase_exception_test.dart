import 'package:flutter_architecture/core/error/exceptions/firebase_exception.dart';
import 'package:flutter_architecture/core/error/failures/firebase_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('toFailure', () {
    test('should return InvalidEmailFailure', () {
      final exceptionTest = InvalidEmailException();

      expect(exceptionTest.toFailure(), isA<InvalidEmailFailure>());
    });

    test('should return WrongPasswordFailure', () {
      final exceptionTest = WrongPasswordException();

      expect(exceptionTest.toFailure(), isA<WrongPasswordFailure>());
    });

    test('should return UserNotFoundFailure', () {
      final exceptionTest = UserNotFoundException();

      expect(exceptionTest.toFailure(), isA<UserNotFoundFailure>());
    });

    test('should return UserDisabledFailure', () {
      final exceptionTest = UserDisabledException();

      expect(exceptionTest.toFailure(), isA<UserDisabledFailure>());
    });

    test('should return TooManyRequestsFailure', () {
      final exceptionTest = TooManyRequestsException();

      expect(exceptionTest.toFailure(), isA<TooManyRequestsFailure>());
    });

    test('should return OperationNotAllowedFailure', () {
      final exceptionTest = OperationNotAllowedException();

      expect(exceptionTest.toFailure(), isA<OperationNotAllowedFailure>());
    });

    test('should return UndefinedFirebaseAuthFailure', () {
      final exceptionTest = UndefinedFirebaseAuthException();

      expect(exceptionTest.toFailure(), isA<UndefinedFirebaseAuthFailure>());
    });

    test('should return WeakPasswordFailure', () {
      final exceptionTest = WeakPasswordException();

      expect(exceptionTest.toFailure(), isA<WeakPasswordFailure>());
    });

    test('should return EmailAlreadyInUseFailure', () {
      final exceptionTest = EmailAlreadyInUseException();

      expect(exceptionTest.toFailure(), isA<EmailAlreadyInUseFailure>());
    });

    test('should return InvalidCredentialFailure', () {
      final exceptionTest = InvalidCredentialException();

      expect(exceptionTest.toFailure(), isA<InvalidCredentialFailure>());
    });

    test('should return AccountExistsWithDifferentCredentialFailure', () {
      final exceptionTest = AccountExistsWithDifferentCredentialException();

      expect(exceptionTest.toFailure(), isA<AccountExistsWithDifferentCredentialFailure>());
    });

    test('should return InvalidActionCodeFailure', () {
      final exceptionTest = InvalidActionCodeException();

      expect(exceptionTest.toFailure(), isA<InvalidActionCodeFailure>());
    });
  });
}
