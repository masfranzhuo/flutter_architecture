import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/account_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginEvent', () {
    test('props are [account]', () {
      final customer = Customer(
        id: 'fake_id',
        name: 'John Doe',
        email: 'john@doe.com',
        accountStatus: AccountStatus.active,
      );
      expect(LoginEvent(account: customer).props, [customer]);
    });
  });
}
