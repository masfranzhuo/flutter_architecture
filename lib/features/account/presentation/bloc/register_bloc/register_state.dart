part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterLoadedState extends RegisterState {
  final Account account;

  RegisterLoadedState({@required this.account});

  @override
  List<Object> get props => [account];
}

class RegisterErrorState extends RegisterState {
  final Failure failure;
  final RegisterErrorGroup error;
  final String message;

  RegisterErrorState({
    @required this.failure,
    this.error,
    this.message,
  });

  @override
  List<Object> get props => [failure];
}
