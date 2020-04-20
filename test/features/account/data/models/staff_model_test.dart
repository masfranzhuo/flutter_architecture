// import 'dart:convert';

// import 'package:flutter_architecture/features/account/data/models/staff_model.dart';
// import 'package:flutter_architecture/features/account/domain/entities/account.dart';
// import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
// import 'package:flutter_test/flutter_test.dart';

// import '../../../../fixtures/fixtures_reader.dart';

// void main() {
//   Map<String, dynamic> staffModelFixture;

//   setUp(() {
//     staffModelFixture = Map<String, dynamic>.from(
//       json.decode(fixture('fixtures/staffs/complete_valid.json')),
//     );
//   });

//   final staffModelTest = StaffModel(
//     id: 'fake_id',
//     name: 'John Doe',
//     email: 'john@doe.com',
//     accountStatus: AccountStatus.active,
//     role: StaffRole.admin,
//     phoneNumber: '1234567890',
//     photoUrl: 'https://fakeimage.com/image.jpg',
//   );

//   test('should be a Staff entity', () async {
//     expect(staffModelTest, isA<Staff>());
//   });

//   group('fromJson', () {
//     test('should return a valid staff model', () async {
//       final result = StaffModel.fromJson(staffModelFixture);

//       expect(result, staffModelTest);
//     });
//   });

//   group('toJson', () {
//     test('should return a JSON map', () async {
//       final result = staffModelTest.toJson();

//       final expectedMap = staffModelFixture;

//       expect(result, expectedMap);
//     });
//   });
// }
