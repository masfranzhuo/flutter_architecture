import 'package:flutter_architecture/features/account/domain/repositories/account_repository.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/change_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  ChangePassword changePassword;
  MockAccountRepository mockAccountRepository;

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    changePassword = ChangePassword(repository: mockAccountRepository);
  });

  test('should call changePassword in repository', () async {
    final passwordTest = 'password';
    final currentPasswordTest = 'currentPassword';

    await changePassword(Params(
      password: passwordTest,
      currentPassword: currentPasswordTest,
    ));
    verify(mockAccountRepository.changePassword(
      password: passwordTest,
      currentPassword: currentPasswordTest,
    ));
  });
}
