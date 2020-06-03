import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/user_profile_form_bloc/user_profile_form_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UpdateUserProfileEvent', () {
    test('props are [account, name, phoneNumber]', () {
      final customer = Customer(
        id: 'fake_id',
        name: 'John Doe',
        email: 'john@doe.com',
        accountStatus: AccountStatus.active,
      );
      final nameTest = 'John Doe';
      final phoneNumberTest = '081212345678';
      expect(
        UpdateUserProfileEvent(
          account: customer,
          name: nameTest,
          phoneNumber: phoneNumberTest,
        ).props,
        [customer, nameTest, phoneNumberTest],
      );
    });
  });
}
