import 'package:flutter_architecture/core/util/json_parsers/date_time.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

class Gender {
  static const male = 'MALE';
  static const female = 'FEMALE';
  static const genderLabel = [
    {male: 'Male'},
    {female: 'Female'},
  ];
}

@JsonSerializable()
class Customer extends Account {
  const Customer({
    @required String id,
    @required String name,
    @required String email,
    @required String accountStatus,
    String phoneNumber,
    String photoUrl,
    String gender,
    String birthPlace,
    DateTime birthDate,
  }) : super(
          id: id,
          name: name,
          email: email,
          accountStatus: accountStatus,
          phoneNumber: phoneNumber,
          photoUrl: photoUrl,
          gender: gender,
          birthPlace: birthPlace,
          birthDate: birthDate,
        );

  @override
  List<Object> get props => [
        id,
        name,
        email,
        accountStatus,
        phoneNumber,
        photoUrl,
        gender,
        birthPlace,
        birthDate,
      ];

  @override
  bool get stringify => true;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
