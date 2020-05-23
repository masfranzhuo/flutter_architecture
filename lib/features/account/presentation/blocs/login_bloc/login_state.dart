part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginLoadedState extends LoginState {
  final Account account;

  LoginLoadedState({@required this.account});

  String get role {
    if (account is Staff) {
      return (account as Staff).role;
    }

    return null;
  }

  bool get isStaff => role != null;

  @override
  List<Object> get props => [account];
}

class LoginErrorState extends LoginState {
  final Failure failure;
  final LoginErrorGroup error;
  final String message;

  LoginErrorState({
    @required this.failure,
    this.error,
    this.message,
  });

  @override
  List<Object> get props => [failure];
}
