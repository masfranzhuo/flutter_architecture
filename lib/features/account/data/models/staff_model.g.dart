// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaffModel _$StaffModelFromJson(Map<String, dynamic> json) {
  return StaffModel(
    id: json['_id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    accountStatus: json['accountStatus'] as String,
    role: json['role'] as String,
    phoneNumber: json['phoneNumber'] as String,
    photoUrl: json['photoUrl'] as String,
  );
}

Map<String, dynamic> _$StaffModelToJson(StaffModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'accountStatus': instance.accountStatus,
      'photoUrl': instance.photoUrl,
      'role': instance.role,
    };
