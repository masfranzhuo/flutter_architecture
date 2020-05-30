part of 'account_bloc.dart';

enum AccountErrorGroup { general, name, phoneNumber }

AccountErrorState _$mapFailureToError(Failure failure) {
  AccountErrorGroup errorGroup = AccountErrorGroup.general;
  String message = 'Undefined Error. ${failure.code} - ${failure.message}';

  if (failure is NameLessThanCharactersFailure) {
    errorGroup = AccountErrorGroup.name;
    message = 'Name minimal 3 characters';
  }

  if (failure is PhoneNumberNotValidFailure) {
    errorGroup = AccountErrorGroup.name;
    message = 'Phone number is not valid';
  }

  return AccountErrorState(
    failure: failure,
    error: errorGroup,
    message: message,
  );
}
