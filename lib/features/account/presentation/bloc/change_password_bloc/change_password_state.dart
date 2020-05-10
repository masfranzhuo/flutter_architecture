part of 'change_password_bloc.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitialState extends ChangePasswordState {}

class ChangePasswordLoadingState extends ChangePasswordState {}

class ChangePasswordLoadedState extends ChangePasswordState {}

class ChangePasswordErrorState extends ChangePasswordState {
  final Failure failure;
  final ChangePasswordErrorGroup error;
  final String message;

  ChangePasswordErrorState({
    @required this.failure,
    this.error,
    this.message,
  });

  @override
  List<Object> get props => [failure];
}
