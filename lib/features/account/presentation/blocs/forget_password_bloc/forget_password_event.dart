part of 'forget_password_bloc.dart';

abstract class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent();
}

class ResetPasswordEvent extends ForgetPasswordEvent {
  final String email;

  ResetPasswordEvent({@required this.email});

  @override
  List<Object> get props => [email];
}
