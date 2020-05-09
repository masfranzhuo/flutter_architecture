import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failure.dart';
import 'package:flutter_architecture/core/util/use_case.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/logout.dart';
import 'package:meta/meta.dart';

part 'account_event.dart';
part 'account_state.dart';
part 'map_failure_to_error.u.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final Logout logout;

  AccountBloc({@required this.logout});

  @override
  AccountState get initialState => AccountInitialState();

  @override
  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {
    if (event is LogoutEvent) {
      yield AccountLoadingState();

      final logoutResult = await logout(NoParams());

      yield logoutResult.fold(
        (failure) => _$mapFailureToError(failure),
        (_) => AccountLoadedState(account: null),
      );
    }
  }
}
