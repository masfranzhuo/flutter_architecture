part of 'user_profile_form_bloc.dart';

enum UserProfileFormErrorGroup { general, name, phoneNumber }

UserProfileFormErrorState _$mapFailureToError(Failure failure) {
  UserProfileFormErrorGroup errorGroup = UserProfileFormErrorGroup.general;
  String message = 'Undefined Error. ${failure.code} - ${failure.message}';

  if (failure is NameLessThanCharactersFailure) {
    errorGroup = UserProfileFormErrorGroup.name;
    message = 'Name minimal 3 characters';
  }

  if (failure is PhoneNumberNotValidFailure) {
    errorGroup = UserProfileFormErrorGroup.phoneNumber;
    message = 'Phone number is not valid';
  }

  return UserProfileFormErrorState(
    failure: failure,
    error: errorGroup,
    message: message,
  );
}
