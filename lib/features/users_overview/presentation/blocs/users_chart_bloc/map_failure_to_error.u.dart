part of 'users_chart_bloc.dart';

enum UsersChartErrorGroup { general }

UsersChartErrorState _$mapFailureToError(Failure failure) {
  UsersChartErrorGroup errorGroup = UsersChartErrorGroup.general;
  String message = 'Undefined Error. ${failure.code} - ${failure.message}';

  return UsersChartErrorState(
    failure: failure,
    error: errorGroup,
    message: message,
  );
}
