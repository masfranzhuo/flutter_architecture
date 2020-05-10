part of 'forget_password_bloc.dart';

enum ForgetPasswordErrorGroup { general, email }

ForgetPasswordErrorState _$mapFailureToError(Failure failure) {
  ForgetPasswordErrorGroup errorGroup = ForgetPasswordErrorGroup.general;
  String message = 'Undefined Error. ${failure.code} - ${failure.message}';

  if (failure is BadEmailFormatFailure || failure is InvalidEmailFailure) {
    errorGroup = ForgetPasswordErrorGroup.email;
    message = 'Invalid email format';
  }

  if (failure is UserNotFoundFailure) {
    errorGroup = ForgetPasswordErrorGroup.email;
    message = 'Email not found';
  }

  return ForgetPasswordErrorState(
    failure: failure,
    error: errorGroup,
    message: message,
  );
}
