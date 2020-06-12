import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/account_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// ignore: must_be_immutable
class MockAccountEvent extends Mock implements AccountEvent {}

void main() {
  group('AccountEvent', () {
    test('props are []', () {
      expect(MockAccountEvent().props, null);
    });
  });

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

  group('GetUserProfileEvent', () {
    test('props are [id]', () {
      final idTest = 'fake_id';
      expect(GetUserProfileEvent(id: idTest).props, [idTest]);
    });
  });
}
