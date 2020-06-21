import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/users_overview/domain/use_cases/get_users.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'users_list_event.dart';
part 'users_list_state.dart';
part 'map_failure_to_error.u.dart';

class UsersListBloc extends Bloc<UsersListEvent, UsersListState> {
  final GetUsers getUsers;

  UsersListBloc({@required this.getUsers});

  @override
  Stream<Transition<UsersListEvent, UsersListState>> transformEvents(
    Stream<UsersListEvent> events,
    TransitionFunction<UsersListEvent, UsersListState> transitionFn,
  ) {
    final defferedEvents = events
        .where((e) => e is GetUsersEvent && e.nodeId != null)
        .debounceTime(const Duration(milliseconds: 500))
        .distinct()
        .switchMap(transitionFn);
    final forwardedEvents = events
        .where((e) => e is GetUsersEvent && e.nodeId == null)
        .asyncExpand(transitionFn);
    return forwardedEvents.mergeWith([defferedEvents]);
  }

  @override
  UsersListState get initialState => UsersListLoadedState();

  @override
  Stream<UsersListState> mapEventToState(
    UsersListEvent event,
  ) async* {
    if (event is GetUsersEvent) {
      /// load empty [] list of data if the first time fetch data
      /// [isLoading] is [true] for the first time fetch data
      if (event.nodeId == null) {
        yield UsersListLoadedState().copyWith(
          users: [],
          isLoading: true,
        );
      }

      final currentState = state as UsersListLoadedState;

      yield currentState.copyWith(
        isLoadMore: true,
      );

      final getUsersDataResult = await getUsers(Params(
        pageSize: event.pageSize,
        nodeId: event.nodeId,
      ));

      yield getUsersDataResult.fold(
        (failure) => _$mapFailureToError(failure),
        (users) {
          final newUsers = currentState.users + users;

          return UsersListLoadedState(
            /// [list.toSet().toList()] remove duplicate list,
            /// because there is bug in fire the scroll controller listener
            /// more than once while at the end of list view in presentation
            /// this is not an efficient way
            // users: newUsers.toSet().toList(),
            users: newUsers,
            isLoading: false,
            isLoadMore: false,
            hasReachMax:
                newUsers.length == currentState.users.length ? true : false,
          );
        },
      );
    }
  }
}
