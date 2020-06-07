import 'package:bloc_test/bloc_test.dart';
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

  blocTest(
    'initial state should be initial',
    build: () async => bloc,
    skip: 0,
    expect: [UserProfileFormInitialState()],
  );
}
