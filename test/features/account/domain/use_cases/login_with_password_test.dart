import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
import 'package:flutter_architecture/features/account/domain/repositories/account_repository.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/login_with_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  LoginWithPassword loginWithPassword;
  MockAccountRepository mockAccountRepository;

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    loginWithPassword = LoginWithPassword(repository: mockAccountRepository);
  });

  final emailTest = 'test';
  final passwordTest = 'test';

  test('should login and return a Staff', () async {
    final staffTest = Staff(
      id: 'fake_id',
      name: 'John Doe',
      email: 'john@doe.com',
      accountStatus: AccountStatus.active,
      role: StaffRole.admin,
    );

    when(mockAccountRepository.loginWithPassword(
      email: anyNamed('email'),
      password: anyNamed('password'),
    )).thenAnswer((_) async => Right(staffTest));

    final result = await loginWithPassword(Params(
      email: emailTest,
      password: passwordTest,
    ));

    expect(result, Right(staffTest));
    verify(mockAccountRepository.loginWithPassword(
      email: emailTest,
      password: passwordTest,
    ));
    verifyNoMoreInteractions(mockAccountRepository);
  });

  test('should login and return a Customer', () async {
    final customerTest = Customer(
      id: 'fake_id',
      name: 'John Doe',
      email: 'john@doe.com',
      accountStatus: AccountStatus.active,
    );

    when(mockAccountRepository.loginWithPassword(
      email: anyNamed('email'),
      password: anyNamed('password'),
    )).thenAnswer((_) async => Right(customerTest));

    final result = await loginWithPassword(Params(
      email: emailTest,
      password: passwordTest,
    ));

    expect(result, Right(customerTest));
    verify(mockAccountRepository.loginWithPassword(
      email: emailTest,
      password: passwordTest,
    ));
    verifyNoMoreInteractions(mockAccountRepository);
  });
}
