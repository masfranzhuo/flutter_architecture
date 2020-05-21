import 'package:flutter_architecture/features/account/presentation/bloc/forget_password_bloc/forget_password_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ResetPasswordEvent ', () {
    test('props are [email]', () {
      final emailTest = 'john@doe.com';
      expect(ResetPasswordEvent(email: emailTest).props, [emailTest]);
    });
  });
}
