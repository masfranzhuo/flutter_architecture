import 'package:flutter_architecture/core/error/exceptions/app_exception.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('toFailure', () {
    test('should return UnexpectedFailure', () {
      final exceptionTest = UnexpectedException();

      expect(exceptionTest.toFailure(), UnexpectedFailure());
    });

    test('should return NetworkFailure', () {
      final exceptionTest = NetworkException();

      expect(exceptionTest.toFailure(), NetworkFailure());
    });

    test('should return InvalidIdTokenFailure', () {
      final exceptionTest = InvalidIdTokenException();

      expect(exceptionTest.toFailure(), InvalidIdTokenFailure());
    });
  });
}
