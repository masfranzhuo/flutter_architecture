import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/util/use_case.dart';
import 'package:flutter_architecture/features/users_overview/domain/use_cases/get_users_data.dart';
import 'package:meta/meta.dart';

part 'users_chart_event.dart';
part 'users_chart_state.dart';
part 'map_failure_to_error.u.dart';

class UsersChartBloc extends Bloc<UsersChartEvent, UsersChartState> {
  final GetUsersData getUsersData;

  UsersChartBloc({
    @required this.getUsersData,
  });

  @override
  UsersChartState get initialState => UsersChartInitialState();

  @override
  Stream<UsersChartState> mapEventToState(
    UsersChartEvent event,
  ) async* {
    if (event is GetUsersDataEvent) {
      yield UsersChartLoadingState();

      final getUsersDataResult = await getUsersData(NoParams());

      yield getUsersDataResult.fold(
        (failure) => _$mapFailureToError(failure),
        (usersData) => UsersChartLoadedState(usersData: usersData),
      );
    }
  }
}
