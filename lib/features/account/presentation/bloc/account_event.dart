part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class LogoutEvent extends AccountEvent {}

class LoginEvent extends AccountEvent {
  final Account account;

  LoginEvent({@required this.account});

  @override
  List<Object> get props => [];
}
