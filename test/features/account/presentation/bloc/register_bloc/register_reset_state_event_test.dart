import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/register_with_password.dart';
import 'package:flutter_architecture/features/account/presentation/bloc/register_bloc/register_bloc.dart';
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

  group('RegisterResetStateEvent', () {
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

    blocTest(
      'should emit [LoginInitialState] when LoginResetStateEvent called',
      build: () async {
        when(mockValidateRegister(any)).thenReturn(Right(true));
        when(mockRegisterWithPassword(any))
            .thenAnswer((_) async => Right(customer));

        bloc.add(RegisterWithPasswordEvent(
          name: nameTest,
          email: emailTest,
          password: passwordTest,
          retypedPassword: retypedPasswordTest,
        ));
        return bloc;
      },
      act: (bloc) => bloc.add(RegisterResetStateEvent()),
      expect: [
        RegisterLoadingState(),
        RegisterLoadedState(account: customer),
        RegisterInitialState(),
      ],
    );
  });
}
