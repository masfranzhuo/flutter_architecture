part of 'users_list_bloc.dart';

abstract class UsersListState extends Equatable {
  const UsersListState();

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [];
}

class UsersListLoadedState extends UsersListState {
  final List<Account> users;
  
  /// [isLoading] is for the whole page loading or first time loading in this case
  /// [isLoadMore] is for loading when reach the bottom of list
  final bool isLoading, isLoadMore;

  UsersListLoadedState({
    this.users = const [],
    this.isLoading = false,
    this.isLoadMore = false,
  });

  UsersListLoadedState copyWith({
    List<Account> users,
    bool isLoading,
    bool isLoadMore,
  }) =>
      UsersListLoadedState(
        users: users ?? this.users,
        isLoading: isLoading ?? this.isLoading,
        isLoadMore: isLoadMore ?? this.isLoadMore,
      );

  @override
  List<Object> get props => [users, isLoading, isLoadMore];
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
