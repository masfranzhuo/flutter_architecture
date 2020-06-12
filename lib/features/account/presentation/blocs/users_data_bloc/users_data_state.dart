part of 'users_data_bloc.dart';

abstract class UsersDataState extends Equatable {
  const UsersDataState();

  @override
  List<Object> get props => [];
}

class UsersDataInitialState extends UsersDataState {}

class UsersDataLoadingState extends UsersDataState {}

class UsersDataLoadedState extends UsersDataState {
  final List<Map<String, dynamic>> usersData;

  UsersDataLoadedState({@required this.usersData});

  @override
  List<Object> get props => [usersData];
}

class UsersDataErrorState extends UsersDataState {
  final Failure failure;
  final UsersDataErrorGroup error;
  final String message;

  UsersDataErrorState({
    @required this.failure,
    this.error,
    this.message,
  });

  @override
  List<Object> get props => [failure];
}
