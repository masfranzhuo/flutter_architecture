import 'package:flutter_architecture/features/account/domain/repositories/account_repository.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/reset_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  ResetPassword resetPassword;
  MockAccountRepository mockAccountRepository;

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    resetPassword = ResetPassword(repository: mockAccountRepository);
  });

  test('should call resetPassword in repository', () async {
    final emailTest = 'john@doe.com';
    await resetPassword(Params(email: emailTest));
    verify(mockAccountRepository.resetPassword(email: emailTest));
  });
}
