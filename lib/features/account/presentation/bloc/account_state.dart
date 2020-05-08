part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitialState extends AccountState {}

class AccountLoadingState extends AccountState {}

class AccountLoadedState extends AccountState {
  final Account account;

  AccountLoadedState({@required this.account});

  bool get isLogin => account != null;

  @override
  List<Object> get props => [account];
}

class AccountErrorState extends AccountState {
  final Failure failure;
  final AccountErrorGroup error;
  final String message;

  AccountErrorState({
    @required this.failure,
    this.error,
    this.message,
  });

  @override
  List<Object> get props => [failure];
}
