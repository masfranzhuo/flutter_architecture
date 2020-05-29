import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
import 'package:flutter_architecture/features/account/domain/repositories/account_repository.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/update_user_profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  UpdateUserProfile updateUserProfile;
  MockAccountRepository mockAccountRepository;

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    updateUserProfile = UpdateUserProfile(repository: mockAccountRepository);
  });

  test('should return staff', () async {
    final staffTest = Staff(
      id: 'fake_id',
      name: 'John Doe',
      email: 'john@doe.com',
      accountStatus: AccountStatus.active,
      role: StaffRole.admin,
    );

    when(mockAccountRepository.updateUserProfile(
      account: staffTest,
    )).thenAnswer((_) async => Right(staffTest));
    final profile = await updateUserProfile(Params(account: staffTest));
    expect(profile, Right(staffTest));
  });

  test('should return customer', () async {
    final customerTest = Customer(
      id: 'fake_id',
      name: 'John Doe',
      email: 'john@doe.com',
      accountStatus: AccountStatus.active,
    );

    when(mockAccountRepository.updateUserProfile(
      account: customerTest,
    )).thenAnswer((_) async => Right(customerTest));
    final profile = await updateUserProfile(Params(account: customerTest));
    expect(profile, Right(customerTest));
  });
}
