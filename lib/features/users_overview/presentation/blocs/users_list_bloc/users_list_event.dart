part of 'users_list_bloc.dart';

abstract class UsersListEvent extends Equatable {
  const UsersListEvent();

  @override
  List<Object> get props => [];
}

class GetUsersEvent extends UsersListEvent {
  final bool isFirstTime;

  GetUsersEvent({this.isFirstTime = false});

  @override
  List<Object> get props => [isFirstTime];
}
