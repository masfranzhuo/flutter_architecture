import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failure.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/reset_password.dart';
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_forget_password.dart'
    as vfp;
import 'package:meta/meta.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';
part 'map_failure_to_error.u.dart';

class ForgetPasswordBloc extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final ResetPassword resetPassword;
  final vfp.ValidateForgetPassword validateForgetPassword;

  ForgetPasswordBloc({
    @required this.resetPassword,
    @required this.validateForgetPassword,
  });

  @override
  ForgetPasswordState get initialState => ForgetPasswordInitialState();

  @override
  Stream<ForgetPasswordState> mapEventToState(
    ForgetPasswordEvent event,
  ) async* {
    if (event is ResetPasswordEvent) {
      final validateForgetPasswordResult = validateForgetPassword(vfp.Params(
        email: event.email,
      ));

      yield* validateForgetPasswordResult.fold(
        (failure) async* {
          yield _$mapFailureToError(failure);
        },
        (success) async* {
          yield ForgetPasswordLoadingState();

          final resetPasswordResult = await resetPassword(Params(
            email: event.email,
          ));

          yield resetPasswordResult.fold(
            (failure) => _$mapFailureToError(failure),
            (_) => ForgetPasswordLoadedState(message: 'Please check your email'),
          );
        },
      );
    }
  }
}
