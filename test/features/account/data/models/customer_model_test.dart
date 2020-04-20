// import 'dart:convert';

// import 'package:flutter_architecture/features/account/data/models/customer_model.dart';
// import 'package:flutter_architecture/features/account/domain/entities/account.dart';
// import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
// import 'package:flutter_test/flutter_test.dart';

// import '../../../../fixtures/fixtures_reader.dart';

// void main() {
//   Map<String, dynamic> customerModelFixture;

//   setUp(() {
//     customerModelFixture = Map<String, dynamic>.from(
//       json.decode(fixture('fixtures/customers/complete_valid.json')),
//     );
//   });

//   final customerModelTest = CustomerModel(
//     id: 'fake_id',
//     name: 'John Doe',
//     email: 'john@doe.com',
//     accountStatus: AccountStatus.active,
//     phoneNumber: '1234567890',
//     photoUrl: 'https://fakeimage.com/image.jpg',
//     gender: Gender.male,
//     birthPlace: 'Indonesia',
//     birthDate: null,
//   );

//   test('should be a Customer entity', () async {
//     expect(customerModelTest, isA<Customer>());
//   });

//   group('fromJson', () {
//     test('should return a valid customer model', () async {
//       final result = CustomerModel.fromJson(customerModelFixture);

//       expect(result, customerModelTest);
//     });
//   });

//   group('toJson', () {
//     test('should return a JSON map', () async {
//       final result = customerModelTest.toJson();

//       final expectedMap = customerModelFixture;

//       expect(result, expectedMap);
//     });
//   });
// }
