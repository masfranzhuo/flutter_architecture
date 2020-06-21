import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/util/json_parsers/date_time.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

class AccountStatus {
  static const active = 'ACTIVE';
  static const inactive = 'INACTIVE';
  /// sample how to use it in [CustomDropdown] widget
  // AccountStatus.accountStatusLabel.forEach((key, value) {
  //   print('CustomDropdownItem(label: $value, value: $key)');
  // });
  static const accountStatusLabel = {
    active: 'Active',
    inactive: 'Inactive',
  };
}

abstract class Account extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String name, email, phoneNumber, accountStatus, photoUrl;
  final String gender, birthPlace;
  @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime birthDate;

  const Account({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.accountStatus,
    this.phoneNumber,
    this.photoUrl,
    this.gender,
    this.birthPlace,
    this.birthDate,
  });
}
