import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final customerMinimumTest = Customer(
    id: 'fake_id',
    name: 'John Doe',
    email: 'john@doe.com',
    accountStatus: AccountStatus.active,
  );

  final customerCompleteTest = Customer(
    id: 'fake_id',
    name: 'John Doe',
    email: 'john@doe.com',
    accountStatus: AccountStatus.active,
    phoneNumber: '1234567890',
    photoUrl: 'https://fakeimage.com/image.jpg',
    gender: Gender.male,
    birthPlace: 'Indonesia',
    birthDate: DateTime(2020),
  );

  test('should be a subclass of Customer entity', () {
    expect(customerMinimumTest, isA<Customer>());
    expect(customerCompleteTest, isA<Customer>());
  });
}
