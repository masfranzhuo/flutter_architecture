import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/error/failures/form_failure.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/update_user_profile.dart'
    as uup;
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_update_user_profile.dart'
    as vuup;
import 'package:meta/meta.dart';

part 'user_profile_form_event.dart';
part 'user_profile_form_state.dart';
part 'map_failure_to_error.u.dart';

class UserProfileFormBloc
    extends Bloc<UserProfileFormEvent, UserProfileFormState> {
  final uup.UpdateUserProfile updateUserProfile;
  final vuup.ValidateUpdateUserProfile validateUpdateUserProfile;

  UserProfileFormBloc({
    @required this.updateUserProfile,
    @required this.validateUpdateUserProfile,
  });

  @override
  UserProfileFormState get initialState => UserProfileFormInitialState();

  @override
  Stream<UserProfileFormState> mapEventToState(
    UserProfileFormEvent event,
  ) async* {
    if (event is UpdateUserProfileEvent) {
      yield* _handleUpdateUserProfileEvent(event);
    } else if (event is UpdateUserProfileImageEvent) {
      yield* _handleUpdateUserProfileImageEvent(event);
    }
  }

  Stream<UserProfileFormState> _handleUpdateUserProfileEvent(
    UpdateUserProfileEvent event,
  ) async* {
    final validateResult = validateUpdateUserProfile(vuup.Params(
      name: event.name,
      phoneNumber: event.phoneNumber,
    ));

    yield* validateResult.fold(
      (failure) async* {
        yield _$mapFailureToError(failure);
      },
      (_) async* {
        yield UserProfileFormLoadingState();

        Account updatedAccount;
        if (event.account is Staff) {
          updatedAccount = (event.account as Staff).copyWith(
            name: event.name,
            phoneNumber: event.phoneNumber,
          );
        } else {
          updatedAccount = (event.account as Customer).copyWith(
            name: event.name,
            phoneNumber: event.phoneNumber,
          );
        }

        final updateResult = await updateUserProfile(uup.Params(
          account: updatedAccount,
        ));

        yield updateResult.fold(
          (failure) => _$mapFailureToError(failure),
          (account) => UserProfileFormLoadedState(account: account),
        );
      },
    );
  }

  Stream<UserProfileFormState> _handleUpdateUserProfileImageEvent(
    UpdateUserProfileImageEvent event,
  ) async* {
    yield UserProfileFormLoadingState();

    Account updatedAccount;
    if (event.account is Staff) {
      updatedAccount = (event.account as Staff).copyWith(
        photoUrl: event.photoUrl,
      );
    } else {
      updatedAccount = (event.account as Customer).copyWith(
        photoUrl: event.photoUrl,
      );
    }

    final updateResult = await updateUserProfile(uup.Params(
      account: updatedAccount,
    ));

    yield updateResult.fold(
      (failure) => _$mapFailureToError(failure),
      (account) => UserProfileFormLoadedState(account: account),
    );
  }
}
