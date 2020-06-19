part of 'users_overview_bloc.dart';

enum UsersOverviewErrorGroup { general }

UsersOverviewErrorState _$mapFailureToError(Failure failure) {
  UsersOverviewErrorGroup errorGroup = UsersOverviewErrorGroup.general;
  String message = 'Undefined Error. ${failure.code} - ${failure.message}';

  return UsersOverviewErrorState(
    failure: failure,
    error: errorGroup,
    message: message,
  );
}
