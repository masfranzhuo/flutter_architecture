import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/util/use_case.dart';
import 'package:flutter_architecture/features/account/domain/repositories/account_repository.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/get_users_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  GetUsersData getUsersData;
  MockAccountRepository mockAccountRepository;

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    getUsersData = GetUsersData(repository: mockAccountRepository);
  });

  test('should return list of user data', () async {
    final usersDataTest = <Map<String, dynamic>>[{}, {}];

    when(mockAccountRepository.getUsersData()).thenAnswer(
      (_) async => Right(usersDataTest),
    );
    final result = await getUsersData(NoParams());
    expect(result, Right(usersDataTest));
  });
}
