import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/account_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  AccountLoadedState state;
  AccountLoadedState stateCustomer;
  AccountLoadedState stateStaff;
  Customer customer;
  Staff staff;

  setUp(() {
    customer = Customer(
      id: 'fake_id',
      name: 'John Doe',
      email: 'john@doe.com',
      accountStatus: AccountStatus.active,
    );
    staff = Staff(
      id: 'fake_id',
      name: 'John Doe',
      email: 'john@doe.com',
      accountStatus: AccountStatus.active,
      role: StaffRole.admin,
    );
    state = AccountLoadedState(account: null);
    stateCustomer = AccountLoadedState(account: customer);
    stateStaff = AccountLoadedState(account: staff);
  });

  group('AccountLoadedState role', () {
    test('should get staff role', () {
      final result = stateStaff.role;
      expect(result, staff.role);
    });
    test('should return null', () {
      final result = stateCustomer.role;
      expect(result, null);
    });
  });

  group('AccountLoadedState isStaff', () {
    test('should return isStaff true', () {
      final result = stateStaff.isStaff;
      expect(result, true);
    });
    test('should return isStaff false', () {
      final result = stateCustomer.isStaff;
      expect(result, false);
    });
  });

  group('AccountLoadedState isLogin', () {
    test('should return isLogin true', () {
      final result = stateStaff.isLogin;
      expect(result, true);
    });
    test('should return isLogin false', () {
      final result = state.isStaff;
      expect(result, false);
    });
  });
}
