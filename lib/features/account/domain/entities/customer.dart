import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:meta/meta.dart';

class Gender {
  static const male = 'MALE';
  static const female = 'FEMALE';
  static const genderLabel = [
    {male: 'Male'},
    {female: 'Female'},
  ];
}

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
}
