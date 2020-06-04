part of 'account_bloc.dart';

enum AccountErrorGroup { general, name, phoneNumber }

AccountErrorState _$mapFailureToError(Failure failure) {
  AccountErrorGroup errorGroup = AccountErrorGroup.general;
  String message = 'Undefined Error. ${failure.code} - ${failure.message}';

  return AccountErrorState(
    failure: failure,
    error: errorGroup,
    message: message,
  );
}
