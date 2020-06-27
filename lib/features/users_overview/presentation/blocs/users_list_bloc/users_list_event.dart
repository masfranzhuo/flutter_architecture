part of 'users_list_bloc.dart';

abstract class UsersListEvent extends Equatable {
  const UsersListEvent();

  @override
  bool get stringify => true;
}

class GetUsersEvent extends UsersListEvent {
  final int pageSize;
  final String nodeId;
  final String query;

  GetUsersEvent({this.pageSize = 5, this.nodeId, this.query});

  @override
  List<Object> get props => [pageSize, nodeId, query];
}
