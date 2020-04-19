import 'package:flutter_architecture/core/error/exception.dart';
import 'package:flutter_architecture/core/error/exception_converter.dart';
import 'package:flutter_architecture/core/error/failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should return UnexpectedFailure', () {
    final result = convertExceptionToFailure(exception: null);

    expect(result, isA<UnexpectedFailure>());
  });

  test('should return UnauthenticatedFailure', () {
    final result = convertExceptionToFailure(
      exception: UnauthenticatedException(),
    );

    expect(result, isA<UnauthenticatedFailure>());
  });
}
