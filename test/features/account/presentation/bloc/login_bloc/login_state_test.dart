import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
import 'package:flutter_architecture/features/account/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  LoginLoadedState stateCustomer;
  LoginLoadedState stateStaff;
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
    stateCustomer = LoginLoadedState(account: customer);
    stateStaff = LoginLoadedState(account: staff);
  });

  group('LoginLoadedState role', () {
    test('should get staff role', () {
      final result = stateStaff.role;
      expect(result, staff.role);
    });
    test('should return null', () {
      final result = stateCustomer.role;
      expect(result, null);
    });
  });

  group('LoginLoadedState isStaff', () {
    test('should return isStaff true', () {
      final result = stateStaff.isStaff;
      expect(result, true);
    });
    test('should return isStaff false', () {
      final result = stateCustomer.isStaff;
      expect(result, false);
    });
  });
}
