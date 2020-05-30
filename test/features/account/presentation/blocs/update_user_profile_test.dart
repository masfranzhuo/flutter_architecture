import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failures/firebase_failure.dart';
import 'package:flutter_architecture/core/error/failures/form_failure.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/logout.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/update_user_profile.dart'
    as uup;
import 'package:flutter_architecture/features/account/presentation/blocs/account_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/login_bloc/login_bloc.dart'
    as lb;
import 'package:flutter_architecture/features/account/presentation/blocs/register_bloc/register_bloc.dart'
    as rb;
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_update_user_profile.dart'
    as vuup;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLogout extends Mock implements Logout {}

class MockLoginBloc extends Mock implements lb.LoginBloc {}

class MockRegisterBloc extends Mock implements rb.RegisterBloc {}

class MockValidateUpdateUserProfile extends Mock
    implements vuup.ValidateUpdateUserProfile {}

class MockUpdateUserProfile extends Mock implements uup.UpdateUserProfile {}

void main() {
  AccountBloc bloc;
  MockLogout mockLogout;
  MockLoginBloc mockLoginBloc;
  MockRegisterBloc mockRegisterBloc;
  MockValidateUpdateUserProfile mockValidateUpdateUserProfile;
  MockUpdateUserProfile mockUpdateUserProfile;

  setUp(() {
    mockLogout = MockLogout();
    mockLoginBloc = MockLoginBloc();
    mockRegisterBloc = MockRegisterBloc();
    mockValidateUpdateUserProfile = MockValidateUpdateUserProfile();
    mockUpdateUserProfile = MockUpdateUserProfile();
    bloc = AccountBloc(
      logout: mockLogout,
      loginBloc: mockLoginBloc,
      registerBloc: mockRegisterBloc,
      validateUpdateUserProfile: mockValidateUpdateUserProfile,
      updateUserProfile: mockUpdateUserProfile,
    );
  });

  tearDown(() {
    bloc?.close();
    mockLoginBloc?.close();
    mockRegisterBloc?.close();
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
    final isStaffTest = false;
    final nameTest = 'John Doe2';
    final phoneNumberTest = '081234567890';

    void setUpSuccessfulValidate() {
      when(mockValidateUpdateUserProfile(any)).thenReturn(Right(true));
    }

    void setUpSuccessfulUpdate() {
      when(mockUpdateUserProfile(any)).thenAnswer((_) async => Right(customer));
    }

    blocTest(
      'should call validateUpdateUserProfile and updateUserProfile',
      build: () async {
        setUpSuccessfulValidate();
        setUpSuccessfulUpdate();
        return bloc;
      },
      act: (bloc) => bloc.add(UpdateUserProfileEvent(
        account: customer,
        isStaff: isStaffTest,
        name: nameTest,
        phoneNumber: phoneNumberTest,
      )),
      verify: (_) async {
        verify(mockValidateUpdateUserProfile(vuup.Params(
          name: nameTest,
          phoneNumber: phoneNumberTest,
        )));
        verify(mockUpdateUserProfile(uup.Params(account: customer)));
      },
    );

    blocTest(
      'should emits [AccountErrorState] with NameLessThanCharactersFailure',
      build: () async {
        when(mockValidateUpdateUserProfile(any)).thenReturn(Left(
          NameLessThanCharactersFailure(),
        ));
        return bloc;
      },
      act: (bloc) => bloc.add(UpdateUserProfileEvent(
        account: customer,
        isStaff: isStaffTest,
        name: nameTest,
        phoneNumber: phoneNumberTest,
      )),
      expect: [AccountErrorState(failure: NameLessThanCharactersFailure())],
    );

    blocTest(
      'should emit [AccountLoadingState,AccountLoadedState] when UpdateUserProfile is successful',
      build: () async {
        setUpSuccessfulValidate();
        setUpSuccessfulUpdate();
        return bloc;
      },
      act: (bloc) => bloc.add(UpdateUserProfileEvent(
        account: customer,
        isStaff: isStaffTest,
        name: nameTest,
        phoneNumber: phoneNumberTest,
      )),
      expect: [
        AccountLoadingState(),
        AccountLoadedState(account: customer),
      ],
    );

    blocTest(
      'should emit [AccountLoadingState,AccountErrorState] when UpdateUserProfile failed',
      build: () async {
        setUpSuccessfulValidate();
        when(mockUpdateUserProfile(any))
            .thenAnswer((_) async => Left(UserDisabledFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(UpdateUserProfileEvent(
        account: customer,
        isStaff: isStaffTest,
        name: nameTest,
        phoneNumber: phoneNumberTest,
      )),
      expect: [
        AccountLoadingState(),
        AccountErrorState(failure: UserDisabledFailure()),
      ],
    );
  });
}
