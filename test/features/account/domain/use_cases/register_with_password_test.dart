import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/repositories/account_repository.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/register_with_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  RegisterWithPassword registerWithPassword;
  MockAccountRepository mockAccountRepository;

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    registerWithPassword =
        RegisterWithPassword(repository: mockAccountRepository);
  });

  test('should register and returning a customer', () async {
    final nameTest = 'John Doe';
    final emailTest = 'test';
    final passwordTest = 'test';
    final customerTest = Customer(
      id: 'fake_id',
      name: 'John Doe',
      email: 'john@doe.com',
      accountStatus: AccountStatus.active,
    );

    when(mockAccountRepository.registerWithPassword(
      name: anyNamed('name'),
      email: anyNamed('email'),
      password: anyNamed('password'),
    )).thenAnswer((_) async => Right(customerTest));

    final result = await registerWithPassword(Params(
      name: nameTest,
      email: emailTest,
      password: passwordTest,
    ));

    expect(result, Right(customerTest));
    verify(mockAccountRepository.registerWithPassword(
      name: nameTest,
      email: emailTest,
      password: passwordTest,
    ));
    verifyNoMoreInteractions(mockAccountRepository);
  });
}
