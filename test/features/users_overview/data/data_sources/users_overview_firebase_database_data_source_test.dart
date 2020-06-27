import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
import 'package:flutter_architecture/features/users_overview/data/data_sources/users_overview_firebase_database_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseDatabase extends Mock implements FirebaseDatabase {}

class MockDatabaseReference extends Mock implements DatabaseReference {}

class MockDataSnapshot extends Mock implements DataSnapshot {}

void main() {
  UsersOverviewFirebaseDatabaseDataSourceImpl dataSource;
  MockFirebaseDatabase mockFirebaseDatabase;

  MockDatabaseReference mockDatabaseReference;
  MockDataSnapshot mockDataSnapshot;

  setUp(() {
    mockFirebaseDatabase = MockFirebaseDatabase();
    dataSource = UsersOverviewFirebaseDatabaseDataSourceImpl(
      firebaseDatabase: mockFirebaseDatabase,
    );

    mockDatabaseReference = MockDatabaseReference();
    mockDataSnapshot = MockDataSnapshot();
  });

  final staffTest = Staff(
    id: 'staff_id',
    name: 'John Doe',
    email: 'john@doe.com',
    accountStatus: AccountStatus.active,
    role: StaffRole.admin,
  );
  final customerTest = Customer(
    id: 'customer_id',
    name: 'John Doe',
    email: 'john@doe.com',
    accountStatus: AccountStatus.active,
  );
  final usersTest = <Account>[staffTest, customerTest];
  final dataSnapshotTest = {
    staffTest.id: staffTest.toJson(),
    customerTest.id: customerTest.toJson(),
  };

  // TODO: test error case
  group('getUsers', () {
    final pageSizeTest = 5;
    final nodeIdTest = 'test01';
    final queryTest = 'query';
    usersTest.sort((a, b) => a.id.compareTo(b.id));

    test('should return list of users when first time fetch data', () async {
      when(mockFirebaseDatabase.reference()).thenAnswer(
        (_) => mockDatabaseReference,
      );
      when(mockDatabaseReference.child(any)).thenReturn(mockDatabaseReference);
      when(mockDatabaseReference.orderByKey()).thenReturn(
        mockDatabaseReference,
      );
      when(mockDatabaseReference.limitToFirst(any)).thenReturn(
        mockDatabaseReference,
      );
      when(mockDatabaseReference.once()).thenAnswer(
        (_) async => mockDataSnapshot,
      );
      when(mockDataSnapshot.value).thenReturn(dataSnapshotTest);

      final result = await dataSource.getUsers(
        pageSize: pageSizeTest,
      );

      verifyInOrder([
        mockFirebaseDatabase.reference(),
        mockDatabaseReference.child(any),
        mockDatabaseReference.orderByKey(),
        mockDatabaseReference.limitToFirst(any),
        mockDatabaseReference.once(),
        mockDataSnapshot.value,
      ]);
      expect(result, usersTest);
    });

    test('should return list of users', () async {
      if (nodeIdTest != null) usersTest.removeAt(0);

      when(mockFirebaseDatabase.reference()).thenAnswer(
        (_) => mockDatabaseReference,
      );
      when(mockDatabaseReference.child(any)).thenReturn(mockDatabaseReference);
      when(mockDatabaseReference.orderByKey()).thenReturn(
        mockDatabaseReference,
      );
      when(mockDatabaseReference.limitToFirst(any)).thenReturn(
        mockDatabaseReference,
      );
      when(mockDatabaseReference.startAt(any)).thenReturn(
        mockDatabaseReference,
      );
      when(mockDatabaseReference.equalTo(any)).thenReturn(
        mockDatabaseReference,
      );
      when(mockDatabaseReference.once()).thenAnswer(
        (_) async => mockDataSnapshot,
      );
      when(mockDataSnapshot.value).thenReturn(dataSnapshotTest);

      final result = await dataSource.getUsers(
        pageSize: pageSizeTest,
        nodeId: nodeIdTest,
        query: queryTest,
      );

      verifyInOrder([
        mockFirebaseDatabase.reference(),
        mockDatabaseReference.child(any),
        mockDatabaseReference.orderByKey(),
        mockDatabaseReference.limitToFirst(any),
        mockDatabaseReference.startAt(any),
        mockDatabaseReference.equalTo(any),
        mockDatabaseReference.once(),
        mockDataSnapshot.value,
      ]);
      expect(result, usersTest);
    });
  });

  group('getUsersData', () {
    final usersDataTest = <Map<String, dynamic>>[
      {
        'status': AccountStatus.accountStatusLabel[AccountStatus.active],
        'count': 2
      },
      {
        'status': AccountStatus.accountStatusLabel[AccountStatus.inactive],
        'count': 0
      }
    ];
    test('should return list of users data', () async {
      when(mockFirebaseDatabase.reference()).thenAnswer(
        (_) => mockDatabaseReference,
      );
      when(mockDatabaseReference.child(any)).thenReturn(mockDatabaseReference);
      when(mockDatabaseReference.orderByKey()).thenReturn(
        mockDatabaseReference,
      );
      when(mockDatabaseReference.once()).thenAnswer(
        (_) async => mockDataSnapshot,
      );
      when(mockDataSnapshot.value).thenReturn(dataSnapshotTest);

      final result = await dataSource.getUsersData();

      verifyInOrder([
        mockFirebaseDatabase.reference(),
        mockDatabaseReference.child(any),
        mockDatabaseReference.orderByKey(),
        mockDatabaseReference.once(),
        mockDataSnapshot.value,
      ]);
      expect(result, usersDataTest);
    });
  });
}
