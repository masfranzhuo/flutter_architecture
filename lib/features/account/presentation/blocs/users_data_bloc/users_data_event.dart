part of 'users_data_bloc.dart';

abstract class UsersDataEvent extends Equatable {
  const UsersDataEvent();

  @override
  List<Object> get props => [];
}

class GetUsersDataEvent extends UsersDataEvent {}
