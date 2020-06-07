import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/util/use_case.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/get_user_profile.dart'
    as gup;
import 'package:flutter_architecture/features/account/domain/use_cases/logout.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/register_bloc/register_bloc.dart';
import 'package:meta/meta.dart';

part 'account_event.dart';
part 'account_state.dart';
part 'map_failure_to_error.u.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final Logout logout;
  final LoginBloc loginBloc;
  final RegisterBloc registerBloc;
  final gup.GetUserProfile getUserProfile;

  StreamSubscription loginBlocSubscription;
  StreamSubscription registerBlocSubscription;

  AccountBloc({
    @required this.logout,
    @required this.loginBloc,
    @required this.registerBloc,
    this.getUserProfile,
  }) {
    loginBlocSubscription = loginBloc.listen((state) {
      if (state is LoginLoadedState) {
        add(LoginEvent(account: state.account));
      }
    });
    registerBlocSubscription = registerBloc.listen((state) {
      if (state is RegisterLoadedState) {
        add(LoginEvent(account: state.account));
      }
    });
  }

  @override
  AccountState get initialState => AccountInitialState();

  @override
  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {
    if (event is LogoutEvent) {
      yield* _handleLogoutEvent(event);
    } else if (event is LoginEvent) {
      yield* _handleLoginEvent(event);
    } else if (event is GetUserProfileEvent) {
      yield* _handleGetUserProfileEvent(event);
    }
  }

  Stream<AccountState> _handleLogoutEvent(LogoutEvent event) async* {
    yield AccountLoadingState();

    final logoutResult = await logout(NoParams());

    yield logoutResult.fold(
      (failure) => _$mapFailureToError(failure),
      (_) {
        loginBloc.add(LoginResetStateEvent());
        registerBloc.add(RegisterResetStateEvent());
        return AccountLoadedState(account: null);
      },
    );
  }

  Stream<AccountState> _handleLoginEvent(LoginEvent event) async* {
    yield AccountLoadingState();
    yield AccountLoadedState(account: event.account);
  }

  Stream<AccountState> _handleGetUserProfileEvent(
    GetUserProfileEvent event,
  ) async* {
    yield AccountLoadingState();

    final getUserProfileResult = await getUserProfile(gup.Params(id: event.id));

    yield getUserProfileResult.fold(
      (failure) => _$mapFailureToError(failure),
      (account) => AccountLoadedState(account: account),
    );
  }

  @override
  Future<void> close() {
    loginBlocSubscription?.cancel();
    registerBlocSubscription?.cancel();
    return super.close();
  }
}
