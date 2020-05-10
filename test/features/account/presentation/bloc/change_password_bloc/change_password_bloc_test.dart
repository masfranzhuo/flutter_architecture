import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failure.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/change_password.dart';
import 'package:flutter_architecture/features/account/presentation/bloc/change_password_bloc/change_password_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_change_password.dart'
    as vcp;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockChangePassword extends Mock implements ChangePassword {}

class MockValidateChangePassword extends Mock
    implements vcp.ValidateChangePassword {}

void main() {
  ChangePasswordBloc bloc;
  MockChangePassword mockChangePassword;
  MockValidateChangePassword mockValidateChangePassword;

  setUp(() {
    mockChangePassword = MockChangePassword();
    mockValidateChangePassword = MockValidateChangePassword();
    bloc = ChangePasswordBloc(
      changePassword: mockChangePassword,
      validateChangePassword: mockValidateChangePassword,
    );
  });

  tearDown(() {
    bloc?.close();
  });

  test('initial state should be initial', () {
    expect(bloc.initialState, isA<ChangePasswordInitialState>());
  });

  group('AccountChangePasswordEvent', () {
    final passwordTest = 'password';
    final retypedPasswordTest = 'password';
    final currentPasswordTest = 'currentPassword';

    void setUpSuccessfulValidateChangePassword() {
      when(mockValidateChangePassword(any)).thenReturn(Right(true));
    }

    void setUpSuccessfulChangePassword() {
      when(mockChangePassword(any)).thenAnswer((_) async => Right(true));
    }

    blocTest(
      'should call validateChangePassword and changePassword',
      build: () async {
        setUpSuccessfulValidateChangePassword();
        setUpSuccessfulChangePassword();
        return bloc;
      },
      act: (bloc) => bloc.add(AccountChangePasswordEvent(
        password: passwordTest,
        retypedPassword: retypedPasswordTest,
        currentPassword: currentPasswordTest,
      )),
      verify: (_) async {
        verify(mockValidateChangePassword(vcp.Params(
          password: passwordTest,
          currentPassword: currentPasswordTest,
        )));
        verify(mockChangePassword(Params(
          password: passwordTest,
          currentPassword: currentPasswordTest,
        )));
      },
    );

    blocTest(
      'should emits [ChangePasswordErrorState] with BadEmailFormatFailure',
      build: () async {
        when(mockValidateChangePassword(any)).thenReturn(Left(
          BadEmailFormatFailure(),
        ));
        return bloc;
      },
      act: (bloc) => bloc.add(AccountChangePasswordEvent(
        password: passwordTest,
        retypedPassword: retypedPasswordTest,
        currentPassword: currentPasswordTest,
      )),
      expect: [ChangePasswordErrorState(failure: BadEmailFormatFailure())],
    );

    blocTest(
      'should emit [ChangePasswordLoadingState,ChangePasswordLoadedState] when ChangePassword is successful',
      build: () async {
        setUpSuccessfulValidateChangePassword();
        setUpSuccessfulChangePassword();
        return bloc;
      },
      act: (bloc) => bloc.add(AccountChangePasswordEvent(
        password: passwordTest,
        retypedPassword: retypedPasswordTest,
        currentPassword: currentPasswordTest,
      )),
      expect: [
        ChangePasswordLoadingState(),
        ChangePasswordLoadedState(),
      ],
    );

    blocTest(
      'should emit [ChangePasswordLoadingState,ChangePasswordErrorState] when ChangePassword failed',
      build: () async {
        setUpSuccessfulValidateChangePassword();
        when(mockChangePassword(any))
            .thenAnswer((_) async => Left(WrongPasswordFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(AccountChangePasswordEvent(
        password: passwordTest,
        retypedPassword: retypedPasswordTest,
        currentPassword: currentPasswordTest,
      )),
      expect: [
        ChangePasswordLoadingState(),
        ChangePasswordErrorState(failure: WrongPasswordFailure()),
      ],
    );
  });
}
