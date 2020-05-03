part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterWithPasswordEvent extends RegisterEvent {
  final String name, email, password, retypedPassword;

  RegisterWithPasswordEvent({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.retypedPassword,
  });

  @override
  List<Object> get props => [name, email, password, retypedPassword];
}
