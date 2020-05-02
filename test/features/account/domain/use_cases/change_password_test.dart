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
    final oldPasswordTest = 'oldPassword';

    await changePassword(Params(
      password: passwordTest,
      oldPassword: oldPasswordTest,
    ));
    verify(mockAccountRepository.changePassword(
      password: passwordTest,
      oldPassword: oldPasswordTest,
    ));
  });
}
