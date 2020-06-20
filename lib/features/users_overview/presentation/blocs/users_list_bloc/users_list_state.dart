part of 'users_list_bloc.dart';

abstract class UsersListState extends Equatable {
  const UsersListState();

  @override
  List<Object> get props => [];
}

class UsersListLoadedState extends UsersListState {
  final List<Account> users;
  final bool isLoading;

  UsersListLoadedState({
    @required this.users,
    @required this.isLoading,
  });

  factory UsersListLoadedState.empty() => UsersListLoadedState(
        users: [],
        isLoading: false,
      );

  UsersListLoadedState copyWith({
    List<Account> users,
    bool isLoading,
  }) =>
      UsersListLoadedState(
        users: users ?? this.users,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object> get props => [users, isLoading];
}

class UsersListErrorState extends UsersListState {
  final Failure failure;
  final UsersListErrorGroup error;
  final String message;

  UsersListErrorState({
    @required this.failure,
    this.error,
    this.message,
  });

  @override
  List<Object> get props => [failure];
}
