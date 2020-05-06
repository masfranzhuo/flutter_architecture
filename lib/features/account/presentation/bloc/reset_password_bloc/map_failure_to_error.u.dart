part of 'reset_password_bloc.dart';

enum ResetPasswordErrorGroup { general, name, email, password, retypePassword }

ResetPasswordErrorState _$mapFailureToError(Failure failure) {
  ResetPasswordErrorGroup errorGroup = ResetPasswordErrorGroup.general;
  String message = 'Undefined Error. ${failure.code} - ${failure.message}';

  if (failure is BadEmailFormatFailure || failure is InvalidEmailFailure) {
    errorGroup = ResetPasswordErrorGroup.email;
    message = 'Invalid email format';
  }

  if (failure is UserNotFoundFailure) {
    errorGroup = ResetPasswordErrorGroup.email;
    message = 'Email not found';
  }

  return ResetPasswordErrorState(
    failure: failure,
    error: errorGroup,
    message: message,
  );
}
