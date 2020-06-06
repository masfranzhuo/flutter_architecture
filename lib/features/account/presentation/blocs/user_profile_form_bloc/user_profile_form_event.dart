part of 'user_profile_form_bloc.dart';

abstract class UserProfileFormEvent extends Equatable {
  const UserProfileFormEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserProfileEvent extends UserProfileFormEvent {
  final Account account;
  final String name;
  final String phoneNumber;

  UpdateUserProfileEvent({
    @required this.account,
    @required this.name,
    this.phoneNumber,
  });

  @override
  List<Object> get props => [account, name, phoneNumber];
}

class UpdateUserProfileImageEvent extends UserProfileFormEvent {
  final Account account;
  final String photoUrl;

  UpdateUserProfileImageEvent({
    @required this.account,
    @required this.photoUrl,
  });

  @override
  List<Object> get props => [account, photoUrl];
}
