part of 'user_profile_form_bloc.dart';

abstract class UserProfileFormState extends Equatable {
  const UserProfileFormState();

  @override
  List<Object> get props => [];
}

class UserProfileFormInitialState extends UserProfileFormState {}

class UserProfileFormLoadingState extends UserProfileFormState {}

class UserProfileFormLoadedState extends UserProfileFormState {
  final Account account;

  UserProfileFormLoadedState({@required this.account});

  @override
  List<Object> get props => [account];
}

class UserProfileFormErrorState extends UserProfileFormState {
  final Failure failure;
  final UserProfileFormErrorGroup error;
  final String message;

  UserProfileFormErrorState({
    @required this.failure,
    this.error,
    this.message,
  });

  @override
  List<Object> get props => [failure];
}
