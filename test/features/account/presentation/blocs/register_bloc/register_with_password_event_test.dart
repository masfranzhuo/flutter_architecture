import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failures/firebase_failure.dart';
import 'package:flutter_architecture/core/error/failures/form_failure.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/register_with_password.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/register_bloc/register_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_register.dart'
    as vr;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRegisterWithPassword extends Mock implements RegisterWithPassword {}

class MockValidateRegister extends Mock implements vr.ValidateRegister {}

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

  group('RegisterWithPasswordEvent', () {
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
    final nameTest = customer?.name;
    final emailTest = customer?.email;
    final passwordTest = '123456';
    final retypedPasswordTest = '123456';

    void setUpSuccessfulValidateRegister() {
      when(mockValidateRegister(any)).thenReturn(Right(true));
    }

    void setUpSuccessfulRegister() {
      when(mockRegisterWithPassword(any))
          .thenAnswer((_) async => Right(customer));
    }

    blocTest(
      'should call validateRegister and registerWithPassword',
      build: () async {
        setUpSuccessfulValidateRegister();
        setUpSuccessfulRegister();
        return bloc;
      },
      act: (bloc) => bloc.add(RegisterWithPasswordEvent(
        name: nameTest,
        email: emailTest,
        password: passwordTest,
        retypedPassword: retypedPasswordTest,
      )),
      verify: (_) async {
        verify(mockValidateRegister(vr.Params(
          name: nameTest,
          email: emailTest,
          password: passwordTest,
          retypedPassword: retypedPasswordTest,
        )));
        verify(mockRegisterWithPassword(Params(
          name: nameTest,
          email: emailTest,
          password: passwordTest,
        )));
      },
    );

    blocTest(
      'should emits [RegisterErrorState] with NameLessThanCharactersFailure',
      build: () async {
        when(mockValidateRegister(any)).thenReturn(Left(
          NameLessThanCharactersFailure(),
        ));
        return bloc;
      },
      act: (bloc) => bloc.add(RegisterWithPasswordEvent(
        name: nameTest,
        email: emailTest,
        password: passwordTest,
        retypedPassword: retypedPasswordTest,
      )),
      expect: [RegisterErrorState(failure: NameLessThanCharactersFailure())],
    );

    blocTest(
      'should emit [RegisterLoadingState,RegisterLoadedState] when RegisterWithPassword is successful',
      build: () async {
        setUpSuccessfulValidateRegister();
        setUpSuccessfulRegister();
        return bloc;
      },
      act: (bloc) => bloc.add(RegisterWithPasswordEvent(
        name: nameTest,
        email: emailTest,
        password: passwordTest,
        retypedPassword: retypedPasswordTest,
      )),
      expect: [
        RegisterLoadingState(),
        RegisterLoadedState(account: customer),
      ],
    );

    blocTest(
      'should emit [RegisterLoadingState,RegisterErrorState] when RegisterWithPassword failed',
      build: () async {
        setUpSuccessfulValidateRegister();
        when(mockRegisterWithPassword(any))
            .thenAnswer((_) async => Left(EmailAlreadyInUseFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(RegisterWithPasswordEvent(
        name: nameTest,
        email: emailTest,
        password: passwordTest,
        retypedPassword: retypedPasswordTest,
      )),
      expect: [
        RegisterLoadingState(),
        RegisterErrorState(failure: EmailAlreadyInUseFailure()),
      ],
    );
  });
}
