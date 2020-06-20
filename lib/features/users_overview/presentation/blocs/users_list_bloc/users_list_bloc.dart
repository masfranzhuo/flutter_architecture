import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/util/use_case.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/users_overview/domain/use_cases/get_users.dart';
import 'package:meta/meta.dart';

part 'users_list_event.dart';
part 'users_list_state.dart';
part 'map_failure_to_error.u.dart';

class UsersListBloc extends Bloc<UsersListEvent, UsersListState> {
  final GetUsers getUsers;

  UsersListBloc({@required this.getUsers});

  @override
  UsersListState get initialState => UsersListLoadedState.empty();

  @override
  Stream<UsersListState> mapEventToState(
    UsersListEvent event,
  ) async* {
    if (event is GetUsersEvent) {
      yield UsersListLoadedState.empty().copyWith(isLoading: true);

      final getUsersDataResult = await getUsers(NoParams());

      yield getUsersDataResult.fold(
        (failure) => _$mapFailureToError(failure),
        (users) => UsersListLoadedState(
          users: users,
          isLoading: false,
        ),
      );
    }
  }
}
