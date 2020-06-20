part of 'users_chart_bloc.dart';

abstract class UsersChartState extends Equatable {
  const UsersChartState();

  @override
  List<Object> get props => [];
}

class UsersChartInitialState extends UsersChartState {}

class UsersChartLoadingState extends UsersChartState {}

class UsersChartLoadedState extends UsersChartState {
  final List<Map<String, dynamic>> usersData;

  UsersChartLoadedState({@required this.usersData});

  @override
  List<Object> get props => [usersData];
}

class UsersChartErrorState extends UsersChartState {
  final Failure failure;
  final UsersChartErrorGroup error;
  final String message;

  UsersChartErrorState({
    @required this.failure,
    this.error,
    this.message,
  });

  @override
  List<Object> get props => [failure];
}
