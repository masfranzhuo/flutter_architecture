import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/register_with_password.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/register_bloc/register_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_register.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRegisterWithPassword extends Mock implements RegisterWithPassword {}

class MockValidateRegister extends Mock implements ValidateRegister {}

void main() {
  RegisterBloc bloc;
  MockRegisterWithPassword mockRegisterWithPassword;
  MockValidateRegister mockValidateRegister;

  setUp(() {
    mockRegisterWithPassword = MockRegisterWithPassword();
    mockValidateRegister = MockValidateRegister();
    bloc = RegisterBloc(
      registerWithPassword: mockRegisterWithPassword,
      validateRegister: mockValidateRegister,
    );
  });

  tearDown(() {
    bloc?.close();
  });

  blocTest(
    'initial state should be initial',
    build: () async => bloc,
    skip: 0,
    expect: [RegisterInitialState()],
  );
}
