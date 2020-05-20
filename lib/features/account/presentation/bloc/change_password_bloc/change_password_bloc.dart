import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/error/failures/firebase_failure.dart';
import 'package:flutter_architecture/core/error/failures/form_failure.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/change_password.dart';
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_change_password.dart'
    as vcp;
import 'package:meta/meta.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';
part 'map_failure_to_error.u.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePassword changePassword;
  final vcp.ValidateChangePassword validateChangePassword;

  ChangePasswordBloc({
    @required this.changePassword,
    @required this.validateChangePassword,
  });

  @override
  ChangePasswordState get initialState => ChangePasswordInitialState();

  @override
  Stream<ChangePasswordState> mapEventToState(
    ChangePasswordEvent event,
  ) async* {
    if (event is AccountChangePasswordEvent) {
      final validateChangePasswordResult = validateChangePassword(vcp.Params(
        currentPassword: event.currentPassword,
        password: event.password,
      ));

      yield* validateChangePasswordResult.fold(
        (failure) async* {
          yield _$mapFailureToError(failure);
        },
        (success) async* {
          yield ChangePasswordLoadingState();

          final changePasswordResult = await changePassword(Params(
            currentPassword: event.currentPassword,
            password: event.password,
          ));

          yield changePasswordResult.fold(
            (failure) => _$mapFailureToError(failure),
            (_) => ChangePasswordLoadedState(),
          );
        },
      );
    }
  }
}
