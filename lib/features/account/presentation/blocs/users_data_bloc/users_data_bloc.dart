import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/util/use_case.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/get_users_data.dart';
import 'package:meta/meta.dart';

part 'users_data_event.dart';
part 'users_data_state.dart';
part 'map_failure_to_error.u.dart';

class UsersDataBloc extends Bloc<UsersDataEvent, UsersDataState> {
  final GetUsersData getUsersData;

  UsersDataBloc({
    @required this.getUsersData,
  });

  @override
  UsersDataState get initialState => UsersDataInitialState();

  @override
  Stream<UsersDataState> mapEventToState(
    UsersDataEvent event,
  ) async* {
    if (event is GetUsersDataEvent) {
      yield UsersDataLoadingState();

      final getUsersDataResult = await getUsersData(NoParams());

      yield getUsersDataResult.fold(
        (failure) => _$mapFailureToError(failure),
        (usersData) => UsersDataLoadedState(usersData: usersData),
      );
    }
  }
}
