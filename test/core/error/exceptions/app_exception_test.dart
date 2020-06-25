import 'package:flutter_architecture/core/error/exceptions/app_exception.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppException', () {
    final messageTest = 'message';
    final exceptionTest = UnexpectedException(message: messageTest);
    test('should return stringify true', () {
      expect(exceptionTest.stringify, true);
    });
    test('should return props [message, code]', () {
      expect(exceptionTest.props, [messageTest, exceptionTest.code]);
    });
  });
  group('toFailure', () {
    test('should return UnexpectedFailure', () {
      final exceptionTest = UnexpectedException();

      expect(
        exceptionTest.toFailure(),
        UnexpectedFailure(
          message: exceptionTest.message,
          code: exceptionTest.code,
        ),
      );
    });

    test('should return NetworkFailure', () {
      final exceptionTest = NetworkException();

      expect(
        exceptionTest.toFailure(),
        NetworkFailure(
          message: exceptionTest.message,
          code: exceptionTest.code,
        ),
      );
    });

    test('should return InvalidIdTokenFailure', () {
      final exceptionTest = InvalidIdTokenException();

      expect(
        exceptionTest.toFailure(),
        InvalidIdTokenFailure(
          message: exceptionTest.message,
          code: exceptionTest.code,
        ),
      );
    });
  });
}
