import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/error/failures/firebase_failure.dart';
import 'package:flutter_architecture/core/error/failures/form_failure.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/login_with_password.dart';
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_login.dart'
    as vl;
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'map_failure_to_error.u.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginWithPassword loginWithPassword;
  final vl.ValidateLogin validateLogin;

  LoginBloc({
    @required this.loginWithPassword,
    @required this.validateLogin,
  });

  @override
  LoginState get initialState => LoginInitialState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginResetStateEvent) {
      yield LoginInitialState();
    } else if (event is LoginWithPasswordEvent) {
      final validateLoginResult = validateLogin(vl.Params(
        email: event.email,
        password: event.password,
      ));

      yield* validateLoginResult.fold(
        (failure) async* {
          yield _$mapFailureToError(failure);
        },
        (success) async* {
          yield LoginLoadingState();

          final loginResult = await loginWithPassword(Params(
            email: event.email,
            password: event.password,
          ));

          yield loginResult.fold(
            (failure) => _$mapFailureToError(failure),
            (account) => LoginLoadedState(account: account),
          );
        },
      );
    }
  }
}
