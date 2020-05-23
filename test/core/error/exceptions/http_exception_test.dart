import 'package:flutter_architecture/core/error/exceptions/http_exception.dart';
import 'package:flutter_architecture/core/error/failures/http_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('toFailure', () {
    test('should return BadRequestFailure', () {
      final exceptionTest = BadRequestException();

      expect(exceptionTest.toFailure(), isA<BadRequestFailure>());
    });

    test('should return UnauthorizedFailure', () {
      final exceptionTest = UnauthorizedException();

      expect(exceptionTest.toFailure(), isA<UnauthorizedFailure>());
    });

    test('should return NotFoundFailure', () {
      final exceptionTest = NotFoundException();

      expect(exceptionTest.toFailure(), isA<NotFoundFailure>());
    });

    test('should return PreconditionFailedFailure', () {
      final exceptionTest = PreconditionFailedException();

      expect(exceptionTest.toFailure(), isA<PreconditionFailedFailure>());
    });

    test('should return InternalServerErrorFailure', () {
      final exceptionTest = InternalServerErrorException();

      expect(exceptionTest.toFailure(), isA<InternalServerErrorFailure>());
    });

    test('should return ServiceUnavailableFailure', () {
      final exceptionTest = ServiceUnavailableException();

      expect(exceptionTest.toFailure(), isA<ServiceUnavailableFailure>());
    });
  });
}
