part of 'login_bloc.dart';

enum LoginErrorGroup { general, email, password }

LoginErrorState _$mapFailureToError(Failure failure) {
  LoginErrorGroup errorGroup = LoginErrorGroup.general;
  String message = 'Undefined Error. ${failure.code} - ${failure.message}';

  if (failure is BadEmailFormatFailure || failure is InvalidEmailFailure) {
    errorGroup = LoginErrorGroup.email;
    message = 'Invalid email format';
  }

  if (failure is InvalidEmailFailure) {
    errorGroup = LoginErrorGroup.email;
    message = 'The email is invalid';
  }

  if (failure is PasswordLessThanCharactersFailure) {
    errorGroup = LoginErrorGroup.password;
    message = 'Password minimal 6 characters';
  }

  if (failure is WrongPasswordFailure) {
    errorGroup = LoginErrorGroup.password;
    message = 'Password is incorrect';
  }

  return LoginErrorState(
    failure: failure,
    error: errorGroup,
    message: message,
  );
}
