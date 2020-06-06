import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
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

  group('UpdateUserProfileImageEvent', () {
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
    final photoUrlTest = 'https://fakeimage.com/image.jpg';

    void setUpSuccessfulUpdate() {
      when(mockUpdateUserProfile(any)).thenAnswer((_) async => Right(customer));
    }

    blocTest(
      'should call validateUpdateUserProfile and updateUserProfile',
      build: () async {
        setUpSuccessfulUpdate();
        return bloc;
      },
      act: (bloc) => bloc.add(UpdateUserProfileImageEvent(
        account: customer,
        photoUrl: photoUrlTest,
      )),
      verify: (_) async {
        verify(mockUpdateUserProfile(uup.Params(account: customer)));
      },
    );

    blocTest(
      'should emit [UserProfileFormLoadingState,UserProfileFormLoadedState] when UpdateUserProfile is successful',
      build: () async {
        setUpSuccessfulUpdate();
        return bloc;
      },
      act: (bloc) => bloc.add(UpdateUserProfileImageEvent(
        account: customer,
        photoUrl: photoUrlTest,
      )),
      expect: [
        UserProfileFormLoadingState(),
        UserProfileFormLoadedState(account: customer),
      ],
    );

    blocTest(
      'should emit [UserProfileFormLoadingState,UserProfileFormErrorState] when UpdateUserProfile failed',
      build: () async {
        when(mockUpdateUserProfile(any))
            .thenAnswer((_) async => Left(InvalidIdTokenFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(UpdateUserProfileImageEvent(
        account: customer,
        photoUrl: photoUrlTest,
      )),
      expect: [
        UserProfileFormLoadingState(),
        UserProfileFormErrorState(failure: InvalidIdTokenFailure()),
      ],
    );
  });
}
