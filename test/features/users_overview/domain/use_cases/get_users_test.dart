import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
import 'package:flutter_architecture/features/users_overview/domain/repositories/users_overview_repository.dart';
import 'package:flutter_architecture/features/users_overview/domain/use_cases/get_users.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUsersOverviewRepository extends Mock
    implements UsersOverviewRepository {}

void main() {
  GetUsers getUsers;
  MockUsersOverviewRepository mockUsersOverviewRepository;

  setUp(() {
    mockUsersOverviewRepository = MockUsersOverviewRepository();
    getUsers = GetUsers(repository: mockUsersOverviewRepository);
  });

  final pageSizeTest = 5;
  final nodeIdTest = 'test01';

  group('Params', () {
    test('props are [pageSize, nodeId]', () {
      expect(
        Params(pageSize: pageSizeTest, nodeId: nodeIdTest).props,
        [pageSizeTest, nodeIdTest],
      );
    });
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

    when(mockUsersOverviewRepository.getUsers(
      pageSize: anyNamed('pageSize'),
      nodeId: anyNamed('nodeId'),
    )).thenAnswer(
      (_) async => Right(usersTest),
    );
    final result = await getUsers(Params(
      pageSize: pageSizeTest,
      nodeId: nodeIdTest,
    ));
    expect(result, Right(usersTest));
  });
}
