import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/util/use_case.dart';
import 'package:flutter_architecture/features/account/domain/repositories/account_repository.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/get_bearer_token.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  GetBearerToken getBearerToken;
  MockAccountRepository mockAccountRepository;

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    getBearerToken = GetBearerToken(repository: mockAccountRepository);
  });

  test('should return bearer token', () async {
    final idTokenTest = 'idToken';

    when(mockAccountRepository.getBearerToken()).thenAnswer(
      (_) async => Right(idTokenTest),
    );

    final result = await getBearerToken(NoParams());

    expect(result, Right(idTokenTest));
  });
}
