part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginResetStateEvent extends LoginEvent {}

class LoginWithPasswordEvent extends LoginEvent {
  final String email, password;

  LoginWithPasswordEvent({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
