import 'dart:convert';

import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
import 'package:flutter_architecture/features/account/domain/factories/account_factory.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  group('AccountFactory', () {
    final customerFixture =
        json.decode(fixture('fixtures/customers/minimum_valid.json'));
    final staffFixture = Map<String, dynamic>.from(
      json.decode(fixture('fixtures/staffs/minimum_valid.json')),
    );
    group('accountFromJson', () {
      test('should return Staff', () {
        final result = AccountFactory.accountFromJson(staffFixture);
        expect(result, isA<Staff>());
      });

      test('should return Customer', () {
        final result = AccountFactory.accountFromJson(customerFixture);
        expect(result, isA<Customer>());
      });
    });
  });
}
