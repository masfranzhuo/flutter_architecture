part of 'users_data_bloc.dart';

enum UsersDataErrorGroup { general }

UsersDataErrorState _$mapFailureToError(Failure failure) {
  UsersDataErrorGroup errorGroup = UsersDataErrorGroup.general;
  String message = 'Undefined Error. ${failure.code} - ${failure.message}';

  return UsersDataErrorState(
    failure: failure,
    error: errorGroup,
    message: message,
  );
}
