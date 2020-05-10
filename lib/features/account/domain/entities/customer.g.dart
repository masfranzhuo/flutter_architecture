// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return Customer(
    id: json['_id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    accountStatus: json['accountStatus'] as String,
    phoneNumber: json['phoneNumber'] as String,
    photoUrl: json['photoUrl'] as String,
    gender: json['gender'] as String,
    birthPlace: json['birthPlace'] as String,
    birthDate: dateTimeFromJson(json['birthDate'] as String),
  );
}

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'accountStatus': instance.accountStatus,
      'photoUrl': instance.photoUrl,
      'gender': instance.gender,
      'birthPlace': instance.birthPlace,
      'birthDate': dateTimeToJson(instance.birthDate),
    };
