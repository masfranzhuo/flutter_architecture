part of 'users_chart_bloc.dart';

abstract class UsersChartEvent extends Equatable {
  const UsersChartEvent();

  @override
  List<Object> get props => [];
}

class GetUsersDataEvent extends UsersChartEvent {}
