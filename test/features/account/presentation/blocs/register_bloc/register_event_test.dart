import 'package:flutter_architecture/features/account/presentation/blocs/register_bloc/register_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RegisterResetStateEvent  ', () {
    test('props are []', () {
      expect(RegisterResetStateEvent().props, []);
    });
  });

  group('RegisterWithPasswordEvent  ', () {
    test('props are [name, email, password, retypedPassword]', () {
      final nameTest = 'John Doe';
      final emailTest = 'john@doe.com';
      final passwordTest = '123456';
      final retypedPasswordTest = '123456';

      expect(
        RegisterWithPasswordEvent(
          name: nameTest,
          email: emailTest,
          password: passwordTest,
          retypedPassword: retypedPasswordTest,
        ).props,
        [nameTest, emailTest, passwordTest, retypedPasswordTest],
      );
    });
  });
}
