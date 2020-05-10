import 'dart:convert';

import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  Map<String, dynamic> staffFixture;
  Staff staff;

  setUp(() {
    staffFixture = Map<String, dynamic>.from(
      json.decode(fixture('fixtures/staffs/complete_valid.json')),
    );
    staff = Staff(
      id: 'fake_id',
      name: 'John Doe',
      email: 'john@doe.com',
      accountStatus: AccountStatus.active,
      role: StaffRole.admin,
      phoneNumber: '1234567890',
      photoUrl: 'https://fakeimage.com/image.jpg',
    );
  });

  test('should be a subclass of Staff entity', () {
    expect(staff, isA<Staff>());
  });

  group('fromJson', () {
    test('should return a valid staff', () async {
      final result = Staff.fromJson(staffFixture);

      expect(result, staff);
    });
  });

  group('toJson', () {
    test('should return a JSON map', () async {
      final result = staff.toJson();

      final expectedMap = staffFixture;

      expect(result, expectedMap);
    });
  });
}
