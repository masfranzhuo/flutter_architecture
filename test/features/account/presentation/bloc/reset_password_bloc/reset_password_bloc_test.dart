import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failure.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/reset_password.dart';
import 'package:flutter_architecture/features/account/presentation/bloc/reset_password_bloc/reset_password_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_reset_password.dart'
    as vrp;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockResetPassword extends Mock implements ResetPassword {}

class MockValidateResetPassword extends Mock
    implements vrp.ValidateResetPassword {}

void main() {
  ResetPasswordBloc bloc;
  MockResetPassword mockResetPassword;
  MockValidateResetPassword mockValidateResetPassword;

  setUp(() {
    mockResetPassword = MockResetPassword();
    mockValidateResetPassword = MockValidateResetPassword();
    bloc = ResetPasswordBloc(
      resetPassword: mockResetPassword,
      validateResetPassword: mockValidateResetPassword,
    );
  });

  tearDown(() {
    bloc?.close();
  });

  test('initial state should be initial', () {
    expect(bloc.initialState, isA<ResetPasswordInitialState>());
  });

  group('AccountResetPasswordEvent', () {
    final emailTest = 'john@doe.com';

    void setUpSuccessfulValidateResetPassword() {
      when(mockValidateResetPassword(any)).thenReturn(Right(true));
    }

    void setUpSuccessfulResetPassword() {
      when(mockResetPassword(any)).thenAnswer((_) async => Right(true));
    }

    blocTest(
      'should call validateResetPassword and resetPassword',
      build: () async {
        setUpSuccessfulValidateResetPassword();
        setUpSuccessfulResetPassword();
        return bloc;
      },
      act: (bloc) => bloc.add(AccountResetPasswordEvent(
        email: emailTest,
      )),
      verify: (_) async {
        verify(mockValidateResetPassword(vrp.Params(
          email: emailTest,
        )));
        verify(mockResetPassword(Params(
          email: emailTest,
        )));
      },
    );

    blocTest(
      'should emits [ResetPasswordErrorState] with BadEmailFormatFailure',
      build: () async {
        when(mockValidateResetPassword(any)).thenReturn(Left(
          BadEmailFormatFailure(),
        ));
        return bloc;
      },
      act: (bloc) => bloc.add(AccountResetPasswordEvent(
        email: emailTest,
      )),
      expect: [ResetPasswordErrorState(failure: BadEmailFormatFailure())],
    );

    blocTest(
      'should emit [ResetPasswordLoadingState,ResetPasswordLoadedState] when ResetPassword is successful',
      build: () async {
        setUpSuccessfulValidateResetPassword();
        setUpSuccessfulResetPassword();
        return bloc;
      },
      act: (bloc) => bloc.add(AccountResetPasswordEvent(
        email: emailTest,
      )),
      expect: [
        ResetPasswordLoadingState(),
        ResetPasswordLoadedState(),
      ],
    );

    blocTest(
      'should emit [ResetPasswordLoadingState,ResetPasswordErrorState] when ResetPassword failed',
      build: () async {
        setUpSuccessfulValidateResetPassword();
        when(mockResetPassword(any))
            .thenAnswer((_) async => Left(WrongPasswordFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(AccountResetPasswordEvent(
        email: emailTest,
      )),
      expect: [
        ResetPasswordLoadingState(),
        ResetPasswordErrorState(failure: WrongPasswordFailure()),
      ],
    );
  });
}
