part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class AccountResetPasswordEvent extends ResetPasswordEvent {
  final String email;

  AccountResetPasswordEvent({@required this.email});

  @override
  List<Object> get props => [email];
}
