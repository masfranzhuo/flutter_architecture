part of 'users_overview_bloc.dart';

abstract class UsersOverviewState extends Equatable {
  const UsersOverviewState();

  @override
  List<Object> get props => [];
}

class UsersOverviewInitialState extends UsersOverviewState {}

class UsersOverviewLoadingState extends UsersOverviewState {}

class UsersOverviewLoadedState extends UsersOverviewState {
  final List<Map<String, dynamic>> usersData;

  UsersOverviewLoadedState({@required this.usersData});

  @override
  List<Object> get props => [usersData];
}

class UsersOverviewErrorState extends UsersOverviewState {
  final Failure failure;
  final UsersOverviewErrorGroup error;
  final String message;

  UsersOverviewErrorState({
    @required this.failure,
    this.error,
    this.message,
  });

  @override
  List<Object> get props => [failure];
}
