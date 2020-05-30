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

  group('copyWith', () {
    test('should copy correctly with new result', () {
      final staffTest = Staff(
        id: 'fake_id',
        name: 'John Doe',
        email: 'john@doe.com',
        accountStatus: AccountStatus.active,
        role: StaffRole.admin,
        phoneNumber: '1234567890',
        photoUrl: 'https://fakeimage.com/image.jpg',
      );

      final copiedStaff = staff.copyWith(
        id: staffTest.id,
        name: staffTest.name,
        email: staffTest.email,
        accountStatus: staffTest.accountStatus,
        role: staffTest.role,
        phoneNumber: staffTest.phoneNumber,
        photoUrl: staffTest.photoUrl,
      );

      expect(copiedStaff.id, staffTest.id);
      expect(copiedStaff.name, staffTest.name);
      expect(copiedStaff.email, staffTest.email);
      expect(copiedStaff.accountStatus, staffTest.accountStatus);
      expect(copiedStaff.role, staffTest.role);
      expect(copiedStaff.phoneNumber, staffTest.phoneNumber);
      expect(copiedStaff.photoUrl, staffTest.photoUrl);
    });
  });
}
