// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) {
  return CustomerModel(
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

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
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
