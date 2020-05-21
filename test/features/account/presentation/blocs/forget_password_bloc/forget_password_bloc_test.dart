import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failures/firebase_failure.dart';
import 'package:flutter_architecture/core/error/failures/form_failure.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/reset_password.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/forget_password_bloc/forget_password_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_forget_password.dart'
    as vfp;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockResetPassword extends Mock implements ResetPassword {}

class MockValidateForgetPassword extends Mock
    implements vfp.ValidateForgetPassword {}

void main() {
  ForgetPasswordBloc bloc;
  MockResetPassword mockResetPassword;
  MockValidateForgetPassword mockValidateForgetPassword;

  setUp(() {
    mockResetPassword = MockResetPassword();
    mockValidateForgetPassword = MockValidateForgetPassword();
    bloc = ForgetPasswordBloc(
      resetPassword: mockResetPassword,
      validateForgetPassword: mockValidateForgetPassword,
    );
  });

  tearDown(() {
    bloc?.close();
  });

  blocTest(
    'initial state should be initial',
    build: () async => bloc,
    skip: 0,
    expect: [ForgetPasswordInitialState()],
  );

  group('ResetPasswordEvent', () {
    final emailTest = 'john@doe.com';

    void setUpSuccessfulValidateForgetPassword() {
      when(mockValidateForgetPassword(any)).thenReturn(Right(true));
    }

    void setUpSuccessfulResetPassword() {
      when(mockResetPassword(any)).thenAnswer((_) async => Right(true));
    }

    blocTest(
      'should call validateForgetPassword and resetPassword',
      build: () async {
        setUpSuccessfulValidateForgetPassword();
        setUpSuccessfulResetPassword();
        return bloc;
      },
      act: (bloc) => bloc.add(ResetPasswordEvent(
        email: emailTest,
      )),
      verify: (_) async {
        verify(mockValidateForgetPassword(vfp.Params(
          email: emailTest,
        )));
        verify(mockResetPassword(Params(
          email: emailTest,
        )));
      },
    );

    blocTest(
      'should emits [ForgetPasswordErrorState] with BadEmailFormatFailure',
      build: () async {
        when(mockValidateForgetPassword(any)).thenReturn(Left(
          BadEmailFormatFailure(),
        ));
        return bloc;
      },
      act: (bloc) => bloc.add(ResetPasswordEvent(
        email: emailTest,
      )),
      expect: [ForgetPasswordErrorState(failure: BadEmailFormatFailure())],
    );

    blocTest(
      'should emit [ForgetPasswordLoadingState,ForgetPasswordLoadedState] when ResetPassword is successful',
      build: () async {
        setUpSuccessfulValidateForgetPassword();
        setUpSuccessfulResetPassword();
        return bloc;
      },
      act: (bloc) => bloc.add(ResetPasswordEvent(
        email: emailTest,
      )),
      expect: [
        ForgetPasswordLoadingState(),
        ForgetPasswordLoadedState(),
      ],
    );

    blocTest(
      'should emit [ForgetPasswordLoadingState,ForgetPasswordErrorState] when ResetPassword failed',
      build: () async {
        setUpSuccessfulValidateForgetPassword();
        when(mockResetPassword(any))
            .thenAnswer((_) async => Left(WrongPasswordFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(ResetPasswordEvent(
        email: emailTest,
      )),
      expect: [
        ForgetPasswordLoadingState(),
        ForgetPasswordErrorState(failure: WrongPasswordFailure()),
      ],
    );
  });
}
