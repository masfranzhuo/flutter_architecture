import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/util/use_case.dart';
import 'package:flutter_architecture/features/users_overview/domain/repositories/users_overview_repository.dart';
import 'package:flutter_architecture/features/users_overview/domain/use_cases/get_users_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUsersOverviewRepository extends Mock implements UsersOverviewRepository {}

void main() {
  GetUsersData getUsersData;
  MockUsersOverviewRepository mockUsersOverviewRepository;

  setUp(() {
    mockUsersOverviewRepository = MockUsersOverviewRepository();
    getUsersData = GetUsersData(repository: mockUsersOverviewRepository);
  });

  test('should return list of user data', () async {
    final usersDataTest = <Map<String, dynamic>>[{}, {}];

    when(mockUsersOverviewRepository.getUsersData()).thenAnswer(
      (_) async => Right(usersDataTest),
    );
    final result = await getUsersData(NoParams());
    expect(result, Right(usersDataTest));
  });
}
