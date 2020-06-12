import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/util/use_case.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
import 'package:flutter_architecture/features/account/domain/repositories/account_repository.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/get_users.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  GetUsers getUsers;
  MockAccountRepository mockAccountRepository;

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    getUsers = GetUsers(repository: mockAccountRepository);
  });

  test('should return list of users', () async {
    final staffTest = Staff(
      id: 'fake_id',
      name: 'John Doe',
      email: 'john@doe.com',
      accountStatus: AccountStatus.active,
      role: StaffRole.admin,
    );
    final customerTest = Customer(
      id: 'fake_id',
      name: 'John Doe',
      email: 'john@doe.com',
      accountStatus: AccountStatus.active,
    );
    final usersTest = <Account>[staffTest, customerTest];

    when(mockAccountRepository.getUsers()).thenAnswer(
      (_) async => Right(usersTest),
    );
    final result = await getUsers(NoParams());
    expect(result, Right(usersTest));
  });
}
