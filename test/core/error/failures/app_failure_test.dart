import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppFailure', () {
    final exceptionTest = UnexpectedFailure();
    test('should return stringify true', () {
      expect(exceptionTest.stringify, true);
    });
  });
}
