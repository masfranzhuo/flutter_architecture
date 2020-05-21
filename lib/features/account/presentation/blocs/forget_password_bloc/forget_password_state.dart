part of 'forget_password_bloc.dart';

abstract class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();

  @override
  List<Object> get props => [];
}

class ForgetPasswordInitialState extends ForgetPasswordState {}

class ForgetPasswordLoadingState extends ForgetPasswordState {}

class ForgetPasswordLoadedState extends ForgetPasswordState {
  final String message;

  ForgetPasswordLoadedState({this.message});

  @override
  List<Object> get props => [];
}

class ForgetPasswordErrorState extends ForgetPasswordState {
  final Failure failure;
  final ForgetPasswordErrorGroup error;
  final String message;

  ForgetPasswordErrorState({
    @required this.failure,
    this.error,
    this.message,
  });

  @override
  List<Object> get props => [failure];
}
