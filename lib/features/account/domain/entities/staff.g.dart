// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Staff _$StaffFromJson(Map<String, dynamic> json) {
  return Staff(
    id: json['_id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    accountStatus: json['accountStatus'] as String,
    role: json['role'] as String,
    phoneNumber: json['phoneNumber'] as String,
    photoUrl: json['photoUrl'] as String,
  );
}

Map<String, dynamic> _$StaffToJson(Staff instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'accountStatus': instance.accountStatus,
      'photoUrl': instance.photoUrl,
      'role': instance.role,
    };
