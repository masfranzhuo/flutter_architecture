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
      if (event.isFirstTime) {
        yield UsersListLoadedState.empty();
      }

      final currentState = state as UsersListLoadedState;

      /// [isLoading] is [true] for the first time fetch data
      /// and [false] for fetch load more data
      /// [isLoadMore] is [true] when fetch the data again
      yield currentState.copyWith(
        isLoading: currentState.users.isEmpty ? true : false,
        isLoadMore: true,
      );

      final getUsersDataResult = await getUsers(NoParams());

      yield getUsersDataResult.fold(
        (failure) => _$mapFailureToError(failure),
        (users) {
          final newUsers = currentState.users + users;

          return UsersListLoadedState(
            users: newUsers,
            isLoading: false,
            isLoadMore: false,
          );
        },
      );
    }
  }
}
