part of 'users_list_bloc.dart';

enum UsersListErrorGroup { general }

UsersListErrorState _$mapFailureToError(Failure failure) {
  UsersListErrorGroup errorGroup = UsersListErrorGroup.general;
  String message = 'Undefined Error. ${failure.code} - ${failure.message}';

  return UsersListErrorState(
    failure: failure,
    error: errorGroup,
    message: message,
  );
}
