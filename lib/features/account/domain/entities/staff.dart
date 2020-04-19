import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:meta/meta.dart';

class StaffRole {
  static const admin = 'ADMIN';
  static const superAdmin = 'SUPER_ADMIN';
  static const staffRoleLabel = [
    {admin: 'Admin'},
    {superAdmin: 'Super Admin'},
  ];
}

class Staff extends Account {
  final String role;

  const Staff({
    @required String id,
    @required String name,
    @required String email,
    @required String accountStatus,
    @required this.role,
    String phoneNumber,
    String photoUrl,
  }) : super(
          id: id,
          name: name,
          email: email,
          accountStatus: accountStatus,
          phoneNumber: phoneNumber,
          photoUrl: photoUrl,
        );

  @override
  List<Object> get props => [
        id,
        name,
        email,
        accountStatus,
        role,
        phoneNumber,
        photoUrl,
      ];
}
