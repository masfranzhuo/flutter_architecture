part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => null;
}

class LogoutEvent extends AccountEvent {}

class LoginEvent extends AccountEvent {
  final Account account;

  LoginEvent({@required this.account});

  @override
  List<Object> get props => [account];
}

class GetUserProfileEvent extends AccountEvent {
  final String id;

  GetUserProfileEvent({@required this.id});

  @override
  List<Object> get props => [id];
}

class UpdateUserProfileEvent extends AccountEvent {
  final Account account;
  final bool isStaff;
  final String name;
  final String phoneNumber;

  UpdateUserProfileEvent({
    @required this.account,
    @required this.isStaff,
    @required this.name,
    this.phoneNumber,
  });

  @override
  List<Object> get props => [account, isStaff, name, phoneNumber];
}
