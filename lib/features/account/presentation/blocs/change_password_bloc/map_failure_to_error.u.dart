part of 'change_password_bloc.dart';

enum ChangePasswordErrorGroup { general, currentPassword, password, retypedPassword }

ChangePasswordErrorState _$mapFailureToError(Failure failure) {
  ChangePasswordErrorGroup errorGroup = ChangePasswordErrorGroup.general;
  String message = 'Undefined Error. ${failure.code} - ${failure.message}';

 if (failure is PasswordAndCurrentPasswordMatchFailure) {
    errorGroup = ChangePasswordErrorGroup.currentPassword;
    message = 'Current password is invalid';
  }

  if (failure is PasswordLessThanCharactersFailure) {
    errorGroup = ChangePasswordErrorGroup.password;
    message = 'Password minimal 6 characters';
  }

  if (failure is WeakPasswordFailure) {
    errorGroup = ChangePasswordErrorGroup.password;
    message = 'This password is weak';
  }

  if (failure is PasswordAndRetypedMismatchFailure) {
    errorGroup = ChangePasswordErrorGroup.retypedPassword;
    message = 'Retyped password is different from password';
  }

  return ChangePasswordErrorState(
    failure: failure,
    error: errorGroup,
    message: message,
  );
}
