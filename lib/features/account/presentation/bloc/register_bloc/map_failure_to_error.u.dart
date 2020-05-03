part of 'register_bloc.dart';

enum RegisterErrorGroup { general, name, email, password, retypePassword }

RegisterErrorState _$mapFailureToError(Failure failure) {
  RegisterErrorGroup errorGroup = RegisterErrorGroup.general;
  String message = 'Undefined Error. ${failure.code} - ${failure.message}';

  if (Failure is NameLessThanCharactersFailure) {
    errorGroup = RegisterErrorGroup.name;
    message = 'Name minimal 3 characters';
  }

  if (failure is BadEmailFormatFailure || failure is InvalidEmailFailure) {
    errorGroup = RegisterErrorGroup.email;
    message = 'Invalid email format';
  }

  if (failure is EmailAlreadyInUseFailure) {
    errorGroup = RegisterErrorGroup.email;
    message = 'Email already in use';
  }

  if (failure is PasswordLessThanCharactersFailure) {
    errorGroup = RegisterErrorGroup.password;
    message = 'Password minimal 6 characters';
  }

  if (failure is WeakPasswordFailure) {
    errorGroup = RegisterErrorGroup.password;
    message = 'This password is weak';
  }

  if (failure is PasswordAndRetypedMismatchFailure) {
    errorGroup = RegisterErrorGroup.retypePassword;
    message = 'Retyped password is different from password';
  }

  return RegisterErrorState(
    failure: failure,
    error: errorGroup,
    message: message,
  );
}
