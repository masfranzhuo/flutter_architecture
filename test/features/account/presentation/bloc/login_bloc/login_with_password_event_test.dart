import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failure.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/login_with_password.dart';
import 'package:flutter_architecture/features/account/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_login.dart'
    as vl;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLoginWithPassword extends Mock implements LoginWithPassword {}

class MockValidateLogin extends Mock implements vl.ValidateLogin {}

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

  group('LoginWithPasswordEvent', () {
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

    void setUpSuccessfulValidateLogin() {
      when(mockValidateLogin(any)).thenReturn(Right(true));
    }

    void setUpSuccessfulLogin() {
      when(mockLoginWithPassword(any)).thenAnswer((_) async => Right(customer));
    }

    blocTest(
      'should call validateLogin and loginWithPassword',
      build: () async {
        setUpSuccessfulValidateLogin();
        setUpSuccessfulLogin();
        return bloc;
      },
      act: (bloc) => bloc.add(LoginWithPasswordEvent(
        email: emailTest,
        password: passwordTest,
      )),
      verify: (_) async {
        verify(mockValidateLogin(vl.Params(
          email: emailTest,
          password: passwordTest,
        )));
        verify(mockLoginWithPassword(Params(
          email: emailTest,
          password: passwordTest,
        )));
      },
    );

    blocTest(
      'should emits [LoginErrorState] with BadEmailFormatFailure',
      build: () async {
        when(mockValidateLogin(any)).thenReturn(Left(
          BadEmailFormatFailure(),
        ));
        return bloc;
      },
      act: (bloc) => bloc.add(LoginWithPasswordEvent(
        email: emailTest,
        password: passwordTest,
      )),
      expect: [LoginErrorState(failure: BadEmailFormatFailure())],
    );

    blocTest(
      'should emit [LoginLoadingState,LoginLoadedState] when LoginWithPassword is successful',
      build: () async {
        setUpSuccessfulValidateLogin();
        setUpSuccessfulLogin();
        return bloc;
      },
      act: (bloc) => bloc.add(LoginWithPasswordEvent(
        email: emailTest,
        password: passwordTest,
      )),
      expect: [
        LoginLoadingState(),
        LoginLoadedState(account: customer),
      ],
    );

    blocTest(
      'should emit [LoginLoadingState,LoginErrorState] when LoginWithPassword failed',
      build: () async {
        setUpSuccessfulValidateLogin();
        when(mockLoginWithPassword(any))
            .thenAnswer((_) async => Left(WrongPasswordFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(LoginWithPasswordEvent(
        email: emailTest,
        password: passwordTest,
      )),
      expect: [
        LoginLoadingState(),
        LoginErrorState(failure: WrongPasswordFailure()),
      ],
    );
  });
}
