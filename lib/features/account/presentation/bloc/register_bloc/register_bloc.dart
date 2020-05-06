import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failure.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/register_with_password.dart';
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_register.dart'
    as vr;
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'map_failure_to_error.u.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterWithPassword registerWithPassword;
  final vr.ValidateRegister validateRegister;

  RegisterBloc({
    @required this.registerWithPassword,
    @required this.validateRegister,
  });

  @override
  RegisterState get initialState => RegisterInitialState();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterWithPasswordEvent) {
      final validateRegisterResult = validateRegister(vr.Params(
        name: event.name,
        email: event.email,
        password: event.password,
        retypedPassword: event.retypedPassword,
      ));

      yield* validateRegisterResult.fold(
        (failure) async* {
          yield _$mapFailureToError(failure);
        },
        (success) async* {
          yield RegisterLoadingState();

          final registerResult = await registerWithPassword(Params(
            name: event.name,
            email: event.email,
            password: event.password,
          ));

          yield registerResult.fold(
            (failure) => _$mapFailureToError(failure),
            (account) => RegisterLoadedState(account: account),
          );
        },
      );
    }
  }
}
