import 'package:flutter_architecture/features/account/presentation/blocs/change_password_bloc/change_password_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AccountChangePasswordEvent', () {
    test('props are [currentPassword, password, retypedPassword]', () {
      final passwordTest = 'password';
      final retypedPasswordTest = 'password';
      final currentPasswordTest = 'currentPassword';
      expect(
        AccountChangePasswordEvent(
          password: passwordTest,
          retypedPassword: retypedPasswordTest,
          currentPassword: currentPasswordTest,
        ).props,
        [currentPasswordTest, passwordTest, retypedPasswordTest],
      );
    });
  });
}
