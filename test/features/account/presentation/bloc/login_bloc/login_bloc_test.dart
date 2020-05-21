import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/login_with_password.dart';
import 'package:flutter_architecture/features/account/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLoginWithPassword extends Mock implements LoginWithPassword {}

class MockValidateLogin extends Mock implements ValidateLogin {}

void main() {
  LoginBloc bloc;
  MockLoginWithPassword mockLoginWithPassword;
  MockValidateLogin mockValidateLogin;

  setUp(() {
    mockLoginWithPassword = MockLoginWithPassword();
    mockValidateLogin = MockValidateLogin();
    bloc = LoginBloc(
      loginWithPassword: mockLoginWithPassword,
      validateLogin: mockValidateLogin,
    );
  });

  tearDown(() {
    bloc?.close();
  });

  blocTest(
    'initial state should be initial',
    build: () async => bloc,
    skip: 0,
    expect: [LoginInitialState()],
  );
}
