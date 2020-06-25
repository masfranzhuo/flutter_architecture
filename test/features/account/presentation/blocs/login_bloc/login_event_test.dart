import 'package:flutter_architecture/features/account/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginResetStateEvent   ', () {
    test('props are []', () {
      expect(LoginResetStateEvent().props, []);
    });
  });

  group('LoginWithPasswordEvent  ', () {
    test('props are [email, password]', () {
      final emailTest = 'john@doe.com';
      final passwordTest = '123456';
      expect(
        LoginWithPasswordEvent(
          email: emailTest,
          password: passwordTest,
        ).props,
        [emailTest, passwordTest],
      );
    });
  });
}
