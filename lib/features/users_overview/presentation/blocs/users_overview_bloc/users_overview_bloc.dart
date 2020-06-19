import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/util/use_case.dart';
import 'package:flutter_architecture/features/users_overview/domain/use_cases/get_users_data.dart';
import 'package:meta/meta.dart';

part 'users_overview_event.dart';
part 'users_overview_state.dart';
part 'map_failure_to_error.u.dart';

class UsersOverviewBloc extends Bloc<UsersOverviewEvent, UsersOverviewState> {
  final GetUsersData getUsersData;

  UsersOverviewBloc({
    @required this.getUsersData,
  });

  @override
  UsersOverviewState get initialState => UsersOverviewInitialState();

  @override
  Stream<UsersOverviewState> mapEventToState(
    UsersOverviewEvent event,
  ) async* {
    if (event is GetUsersDataEvent) {
      yield UsersOverviewLoadingState();

      final getUsersDataResult = await getUsersData(NoParams());

      yield getUsersDataResult.fold(
        (failure) => _$mapFailureToError(failure),
        (usersData) => UsersOverviewLoadedState(usersData: usersData),
      );
    }
  }
}
