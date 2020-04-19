import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final staffMinimumTest = Staff(
    id: 'fake_id',
    name: 'John Doe',
    email: 'john@doe.com',
    accountStatus: AccountStatus.active,
    role: StaffRole.admin,
  );

  final staffCompleteTest = Staff(
    id: 'fake_id',
    name: 'John Doe',
    email: 'john@doe.com',
    accountStatus: AccountStatus.active,
    role: StaffRole.admin,
    phoneNumber: '1234567890',
    photoUrl: 'https://fakeimage.com/image.jpg',
  );

  test('should be a subclass of Staff entity', () {
    expect(staffMinimumTest, isA<Staff>());
    expect(staffCompleteTest, isA<Staff>());
  });
}
