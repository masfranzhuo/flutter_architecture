import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'staff.g.dart';

class StaffRole {
  static const admin = 'ADMIN';
  static const superAdmin = 'SUPER_ADMIN';
  static const staffRoleLabel = [
    {admin: 'Admin'},
    {superAdmin: 'Super Admin'},
  ];
}

@JsonSerializable()
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

  @override
  bool get stringify => true;

  Staff copyWith({
    String id,
    String name,
    String email,
    String accountStatus,
    String role,
    String phoneNumber,
    String photoUrl,
  }) =>
      Staff(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        accountStatus: accountStatus ?? this.accountStatus,
        role: role ?? this.role,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        photoUrl: photoUrl ?? this.photoUrl,
      );

  factory Staff.fromJson(Map<String, dynamic> json) => _$StaffFromJson(json);

  Map<String, dynamic> toJson() => _$StaffToJson(this);
}
