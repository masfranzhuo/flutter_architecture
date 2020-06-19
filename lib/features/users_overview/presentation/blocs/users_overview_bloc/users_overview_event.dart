part of 'users_overview_bloc.dart';

abstract class UsersOverviewEvent extends Equatable {
  const UsersOverviewEvent();

  @override
  List<Object> get props => [];
}

class GetUsersDataEvent extends UsersOverviewEvent {}
