import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
import 'package:flutter_architecture/features/account/domain/repositories/account_repository.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/get_user_profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  GetUserProfile getUserProfile;
  MockAccountRepository mockAccountRepository;

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    getUserProfile = GetUserProfile(repository: mockAccountRepository);
  });

  test('should return staff/customer', () async {
    final idTest = 'idTest';
    final staffTest = Staff(
      id: 'fake_id',
      name: 'John Doe',
      email: 'john@doe.com',
      accountStatus: AccountStatus.active,
      role: StaffRole.admin,
    );

    when(mockAccountRepository.getUserProfile(id: idTest))
        .thenAnswer((_) async => Right(staffTest));
    final profile = await getUserProfile(Params(id: idTest));
    expect(profile, Right(staffTest));
  });

  test('should return staff/customer', () async {
    final customerTest = Customer(
      id: 'fake_id',
      name: 'John Doe',
      email: 'john@doe.com',
      accountStatus: AccountStatus.active,
    );

    when(mockAccountRepository.getUserProfile(id: null))
        .thenAnswer((_) async => Right(customerTest));
    final profile = await getUserProfile(Params());
    expect(profile, Right(customerTest));
  });
}
