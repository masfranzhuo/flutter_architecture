import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';

class AccountFactory {
  static Account accountFromJson(Map<String, dynamic> json) {
    if (json['role'] != null) {
      return Staff.fromJson(json);
    } else {
      return Customer.fromJson(json);
    }
  }
}
