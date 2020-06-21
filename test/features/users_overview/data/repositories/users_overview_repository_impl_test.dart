import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/exceptions/app_exception.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
import 'package:flutter_architecture/features/users_overview/data/data_sources/users_overview_firebase_database_data_source.dart';
import 'package:flutter_architecture/features/users_overview/data/repositories/users_overview_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUsersOverviewFirebaseDatabaseDataSource extends Mock
    implements UsersOverviewFirebaseDatabaseDataSource {}

// ignore: must_be_immutable
class MockAppException extends Mock implements AppException {}

// ignore: must_be_immutable
class MockFailure extends Mock implements Failure {}

// ignore: must_be_immutable
class MockStaff extends Mock implements Staff {}

// ignore: must_be_immutable
class MockCustomer extends Mock implements Customer {}

void main() {
  UsersOverviewRepositoryImpl repository;
  MockUsersOverviewFirebaseDatabaseDataSource mockDataSource;

  MockAppException mockAppException;
  MockFailure mockFailure;
  MockStaff mockStaff;
  MockCustomer mockCustomer;

  setUp(() {
    mockDataSource = MockUsersOverviewFirebaseDatabaseDataSource();
    repository = UsersOverviewRepositoryImpl(
      firebaseDatabaseDataSource: mockDataSource,
    );

    mockAppException = MockAppException();
    mockFailure = MockFailure();
    mockStaff = MockStaff();
    mockCustomer = MockCustomer();
  });
  group('getUsers', () {
    final pageSizeTest = 5;
    final nodeIdTest = 'test01';
    final usersTest = [mockStaff, mockCustomer];
    test('should get list of users', () async {
      when(mockDataSource.getUsers(
        pageSize: anyNamed('pageSize'),
        nodeId: anyNamed('nodeId'),
      )).thenAnswer(
        (_) async => usersTest,
      );

      final result = await repository.getUsers(
        pageSize: pageSizeTest,
        nodeId: nodeIdTest,
      );

      verify(mockDataSource.getUsers(
        pageSize: anyNamed('pageSize'),
        nodeId: anyNamed('nodeId'),
      ));
      expect(result, Right(usersTest));
    });

    test('should return UnexpectedFailure', () async {
      when(mockDataSource.getUsers()).thenThrow(
        Exception(),
      );

      final result = await repository.getUsers();

      expect((result as Left).value, isA<UnexpectedFailure>());
    });

    test(
      'should call toFailure if exception is AppException',
      () async {
        when(mockAppException.toFailure()).thenReturn(mockFailure);
        when(mockDataSource.getUsers()).thenThrow(
          mockAppException,
        );

        final result = await repository.getUsers();

        expect((result as Left).value, mockFailure);
        expect((result as Left).value, isA<Failure>());
      },
    );
  });

  group('getUsersData', () {
    final usersDataTest = <Map<String, dynamic>>[{}, {}];

    test('should get list of users data', () async {
      when(mockDataSource.getUsersData()).thenAnswer(
        (_) async => usersDataTest,
      );

      final result = await repository.getUsersData();

      verify(mockDataSource.getUsersData());
      expect(result, Right(usersDataTest));
    });

    test('should return UnexpectedFailure', () async {
      when(mockDataSource.getUsersData()).thenThrow(
        Exception(),
      );

      final result = await repository.getUsersData();

      expect((result as Left).value, isA<UnexpectedFailure>());
    });

    test(
      'should call toFailure if exception is AppException',
      () async {
        when(mockAppException.toFailure()).thenReturn(mockFailure);
        when(mockDataSource.getUsersData()).thenThrow(
          mockAppException,
        );

        final result = await repository.getUsersData();

        expect((result as Left).value, mockFailure);
        expect((result as Left).value, isA<Failure>());
      },
    );
  });
}
