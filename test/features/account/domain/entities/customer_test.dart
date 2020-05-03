import 'dart:convert';

import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  Map<String, dynamic> customerFixture;
  Customer customer;

  setUp(() {
    customerFixture = Map<String, dynamic>.from(
      json.decode(fixture('fixtures/customers/complete_valid.json')),
    );
    customer = Customer(
      id: 'fake_id',
      name: 'John Doe',
      email: 'john@doe.com',
      accountStatus: AccountStatus.active,
      phoneNumber: '1234567890',
      photoUrl: 'https://fakeimage.com/image.jpg',
      gender: Gender.male,
      birthPlace: 'Indonesia',
      birthDate: DateTime.parse("2019-09-01T13:00:00.000Z"),
    );
  });

  test('should be a subclass of Customer entity', () {
    expect(customer, isA<Customer>());
  });

  group('fromJson', () {
    test('should return a valid customer', () async {
      final result = Customer.fromJson(customerFixture);

      expect(result, customer);
    });
  });

  group('toJson', () {
    test('should return a JSON map', () async {
      final result = customer.toJson();

      final expectedMap = customerFixture;

      expect(result, expectedMap);
    });
  });
}
