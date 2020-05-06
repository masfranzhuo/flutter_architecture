import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failure.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/reset_password.dart';
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_reset_password.dart'
    as vrp;
import 'package:meta/meta.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';
part 'map_failure_to_error.u.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ResetPassword resetPassword;
  final vrp.ValidateResetPassword validateResetPassword;

  ResetPasswordBloc({
    @required this.resetPassword,
    @required this.validateResetPassword,
  });

  @override
  ResetPasswordState get initialState => ResetPasswordInitialState();

  @override
  Stream<ResetPasswordState> mapEventToState(
    ResetPasswordEvent event,
  ) async* {
    if (event is AccountResetPasswordEvent) {
      final validateResetPasswrodResult = validateResetPassword(vrp.Params(
        email: event.email,
      ));

      yield* validateResetPasswrodResult.fold(
        (failure) async* {
          yield _$mapFailureToError(failure);
        },
        (success) async* {
          yield ResetPasswordLoadingState();

          final resetPasswordResult = await resetPassword(Params(
            email: event.email,
          ));

          yield resetPasswordResult.fold(
            (failure) => _$mapFailureToError(failure),
            (_) => ResetPasswordLoadedState(),
          );
        },
      );
    }
  }
}
