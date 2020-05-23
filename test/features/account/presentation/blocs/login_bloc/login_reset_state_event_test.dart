import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/login_with_password.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/login_bloc/login_bloc.dart';
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

  group('LoginResetStateEvent', () {
    final customer = Customer(
      id: 'fake_id',
      name: 'John Doe',
      email: 'john@doe.com',
      accountStatus: AccountStatus.active,
      phoneNumber: '1234567890',
      photoUrl: 'https://fakeimage.com/image.jpg',
      gender: Gender.male,
      birthPlace: 'Indonesia',
      birthDate: DateTime.now(),
    );
    final emailTest = customer?.email;
    final passwordTest = '123456';

    blocTest(
      'should emit [LoginInitialState] when LoginResetStateEvent called',
      build: () async {
        when(mockValidateLogin(any)).thenReturn(Right(true));
        when(mockLoginWithPassword(any))
            .thenAnswer((_) async => Right(customer));

        bloc.add(LoginWithPasswordEvent(
          email: emailTest,
          password: passwordTest,
        ));
        return bloc;
      },
      act: (bloc) => bloc.add(LoginResetStateEvent()),
      expect: [
        LoginLoadingState(),
        LoginLoadedState(account: customer),
        LoginInitialState(),
      ],
    );
  });
}
