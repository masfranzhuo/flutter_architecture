import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/util/use_case.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
import 'package:flutter_architecture/features/account/domain/repositories/account_repository.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/auto_login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  AutoLogin autoLogin;
  MockAccountRepository mockAccountRepository;

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    autoLogin = AutoLogin(repository: mockAccountRepository);
  });

  test('should return staff', () async {
    final staffTest = Staff(
      id: 'fake_id',
      name: 'John Doe',
      email: 'john@doe.com',
      accountStatus: AccountStatus.active,
      role: StaffRole.admin,
    );

    when(mockAccountRepository.autoLogin()).thenAnswer(
      (_) async => Right(staffTest),
    );
    final profile = await autoLogin(NoParams());
    expect(profile, Right(staffTest));
  });

  test('should return customer', () async {
    final customerTest = Customer(
      id: 'fake_id',
      name: 'John Doe',
      email: 'john@doe.com',
      accountStatus: AccountStatus.active,
    );

    when(mockAccountRepository.autoLogin()).thenAnswer(
      (_) async => Right(customerTest),
    );
    final profile = await autoLogin(NoParams());
    expect(profile, Right(customerTest));
  });
}
