import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failures/firebase_failure.dart';
import 'package:flutter_architecture/core/error/failures/form_failure.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/update_user_profile.dart'
    as uup;
import 'package:flutter_architecture/features/account/presentation/blocs/user_profile_form_bloc/user_profile_form_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_update_user_profile.dart'
    as vuup;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUpdateUserProfile extends Mock implements uup.UpdateUserProfile {}

class MockValidateUpdateUserProfile extends Mock
    implements vuup.ValidateUpdateUserProfile {}

void main() {
  UserProfileFormBloc bloc;
  MockUpdateUserProfile mockUpdateUserProfile;
  MockValidateUpdateUserProfile mockValidateUpdateUserProfile;

  setUp(() {
    mockUpdateUserProfile = MockUpdateUserProfile();
    mockValidateUpdateUserProfile = MockValidateUpdateUserProfile();
    bloc = UserProfileFormBloc(
      updateUserProfile: mockUpdateUserProfile,
      validateUpdateUserProfile: mockValidateUpdateUserProfile,
    );
  });

  tearDown(() {
    bloc?.close();
  });

  group('UpdateUserProfileEvent', () {
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
      'should emits [UserProfileFormErrorState] with NameLessThanCharactersFailure',
      build: () async {
        when(mockValidateUpdateUserProfile(any)).thenReturn(Left(
          NameLessThanCharactersFailure(),
        ));
        return bloc;
      },
      act: (bloc) => bloc.add(UpdateUserProfileEvent(
        account: customer,
        name: nameTest,
        phoneNumber: phoneNumberTest,
      )),
      expect: [
        UserProfileFormErrorState(failure: NameLessThanCharactersFailure())
      ],
    );

    blocTest(
      'should emit [UserProfileFormLoadingState,UserProfileFormLoadedState] when UpdateUserProfile is successful',
      build: () async {
        setUpSuccessfulValidate();
        setUpSuccessfulUpdate();
        return bloc;
      },
      act: (bloc) => bloc.add(UpdateUserProfileEvent(
        account: customer,
        name: nameTest,
        phoneNumber: phoneNumberTest,
      )),
      expect: [
        UserProfileFormLoadingState(),
        UserProfileFormLoadedState(account: customer),
      ],
    );

    blocTest(
      'should emit [UserProfileFormLoadingState,UserProfileFormErrorState] when UpdateUserProfile failed',
      build: () async {
        setUpSuccessfulValidate();
        when(mockUpdateUserProfile(any))
            .thenAnswer((_) async => Left(UserDisabledFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(UpdateUserProfileEvent(
        account: customer,
        name: nameTest,
        phoneNumber: phoneNumberTest,
      )),
      expect: [
        UserProfileFormLoadingState(),
        UserProfileFormErrorState(failure: UserDisabledFailure()),
      ],
    );
  });
}
