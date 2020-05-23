part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class AccountChangePasswordEvent extends ChangePasswordEvent {
  final String currentPassword, password, retypedPassword;

  AccountChangePasswordEvent({
    @required this.currentPassword,
    @required this.password,
    @required this.retypedPassword,
  });

  @override
  List<Object> get props => [currentPassword, password, retypedPassword];
}
