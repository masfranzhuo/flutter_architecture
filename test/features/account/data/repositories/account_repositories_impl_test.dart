import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_architecture/core/error/exceptions/app_exception.dart';
import 'package:flutter_architecture/core/error/exceptions/http_exception.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/error/failures/http_failure.dart';
import 'package:flutter_architecture/features/account/data/data_sources/account_data_source.dart';
import 'package:flutter_architecture/features/account/data/data_sources/firebase_auth_data_source.dart';
import 'package:flutter_architecture/features/account/data/data_sources/firebase_messaging_data_source.dart';
import 'package:flutter_architecture/features/account/data/data_sources/firebase_realtime_data_source.dart';
import 'package:flutter_architecture/features/account/data/repositories/account_repository_impl.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixtures_reader.dart';

class MockAccountDataSource extends Mock implements AccountDataSource {}

class MockFirebaseAuthDataSource extends Mock
    implements FirebaseAuthDataSource {}

class MockFirebaseMessagingDataSource extends Mock
    implements FirebaseMessagingDataSource {}

class MockFirebaseRealtimeDataSource extends Mock
    implements FirebaseRealtimeDataSource {}

class MockFirebaseUser extends Mock implements FirebaseUser {}

// ignore: must_be_immutable
class MockAppException extends Mock implements AppException {}

// ignore: must_be_immutable
class MockFailure extends Mock implements Failure {}

// ignore: must_be_immutable
class MockStaff extends Mock implements Staff {}

// ignore: must_be_immutable
class MockCustomer extends Mock implements Customer {}

void main() {
  AccountRepositoryImpl repository;
  MockAccountDataSource mockAccountDataSource;
  MockFirebaseAuthDataSource mockFirebaseAuthDataSource;
  MockFirebaseMessagingDataSource mockFirebaseMessagingDataSource;
  MockFirebaseRealtimeDataSource mockFirebaseRealtimeDataSource;

  MockFirebaseUser mockFirebaseUser;
  MockAppException mockAppException;
  MockFailure mockFailure;
  MockStaff mockStaff;
  MockCustomer mockCustomer;

  setUp(() {
    mockAccountDataSource = MockAccountDataSource();
    mockFirebaseAuthDataSource = MockFirebaseAuthDataSource();
    mockFirebaseMessagingDataSource = MockFirebaseMessagingDataSource();
    mockFirebaseRealtimeDataSource = MockFirebaseRealtimeDataSource();
    repository = AccountRepositoryImpl(
      accountDataSource: mockAccountDataSource,
      firebaseAuthDataSource: mockFirebaseAuthDataSource,
      firebaseMessagingDataSource: mockFirebaseMessagingDataSource,
      firebaseRealtimeDataSource: mockFirebaseRealtimeDataSource,
    );

    mockFirebaseUser = MockFirebaseUser();
    mockAppException = MockAppException();
    mockFailure = MockFailure();
    mockStaff = MockStaff();
    mockCustomer = MockCustomer();
  });

  final idTest = 'user_uid';
  final emailTest = 'test';
  final passwordTest = 'test';

  group('loginWithPassword', () {
    test('should login as a staff', () async {
      when(mockFirebaseAuthDataSource.signInWithPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => mockFirebaseUser);
      when(mockAccountDataSource.getUserProfile(
        id: anyNamed('id'),
      )).thenAnswer((_) async => mockStaff);

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      verifyInOrder([
        mockFirebaseAuthDataSource.signInWithPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        ),
        mockFirebaseMessagingDataSource.getDeviceToken(),
        mockAccountDataSource.setUserProfile(
          id: anyNamed('id'),
          deviceToken: anyNamed('deviceToken'),
        ),
        mockAccountDataSource.getUserProfile(id: anyNamed('id')),
      ]);
      expect(result, Right(mockStaff));
    });

    test('should login as a customer', () async {
      when(mockFirebaseAuthDataSource.signInWithPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => mockFirebaseUser);
      when(mockAccountDataSource.getUserProfile(
        id: anyNamed('id'),
      )).thenAnswer((_) async => mockCustomer);

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      verifyInOrder([
        mockFirebaseAuthDataSource.signInWithPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        ),
        mockFirebaseMessagingDataSource.getDeviceToken(),
        mockAccountDataSource.setUserProfile(
          id: anyNamed('id'),
          deviceToken: anyNamed('deviceToken'),
        ),
        mockAccountDataSource.getUserProfile(id: anyNamed('id')),
      ]);
      expect(result, Right(mockCustomer));
    });

    test('should return UnexpectedFailure', () async {
      when(mockFirebaseAuthDataSource.signInWithPassword(
        email: emailTest,
        password: passwordTest,
      )).thenThrow(UnexpectedException());

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      expect((result as Left).value, isA<UnexpectedFailure>());
    });

    test(
      'should call toFailure if exception is AppException',
      () async {
        when(mockAppException.toFailure()).thenReturn(mockFailure);
        when(mockFirebaseAuthDataSource.signInWithPassword(
          email: emailTest,
          password: passwordTest,
        )).thenThrow(mockAppException);

        final result = await repository.loginWithPassword(
          email: emailTest,
          password: passwordTest,
        );

        expect((result as Left).value, mockFailure);
        expect((result as Left).value, isA<Failure>());
      },
    );

    test('should return UnexpectedFailure', () async {
      when(mockFirebaseAuthDataSource.signInWithPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => mockFirebaseUser);
      when(mockAccountDataSource.setUserProfile(
        id: anyNamed('id'),
        deviceToken: anyNamed('deviceToken'),
      )).thenThrow(UnexpectedException());

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      expect((result as Left).value, isA<UnexpectedFailure>());
    });

    test(
      'should call toFailure if exception is AppException',
      () async {
        when(mockFirebaseAuthDataSource.signInWithPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => mockFirebaseUser);
        when(mockAppException.toFailure()).thenReturn(mockFailure);
        when(mockAccountDataSource.setUserProfile(
          id: anyNamed('id'),
          deviceToken: anyNamed('deviceToken'),
        )).thenThrow(mockAppException);

        final result = await repository.loginWithPassword(
          email: emailTest,
          password: passwordTest,
        );

        expect((result as Left).value, mockFailure);
        expect((result as Left).value, isA<Failure>());
      },
    );
  });

  group('registerWithPassword', () {
    final nameTest = 'John Doe';
    final photoUrlTest = 'https://fakeimage.com/image.jpg';

    test('should return a staff', () async {
      when(mockFirebaseAuthDataSource.signUpWithPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => mockFirebaseUser);
      when(mockAccountDataSource.getUserProfile(
        id: anyNamed('id'),
      )).thenAnswer((_) async => mockStaff);

      final result = await repository.registerWithPassword(
        name: nameTest,
        email: emailTest,
        password: passwordTest,
      );

      verifyInOrder([
        mockFirebaseAuthDataSource.signUpWithPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        ),
        mockFirebaseAuthDataSource.updateProfile(
          updateInfo: anyNamed('updateInfo'),
        ),
        mockFirebaseMessagingDataSource.getDeviceToken(),
        mockAccountDataSource.setUserProfile(
          id: anyNamed('id'),
          deviceToken: anyNamed('deviceToken'),
          name: anyNamed('name'),
          email: anyNamed('email'),
        ),
        mockAccountDataSource.getUserProfile(id: anyNamed('id')),
      ]);
      expect(result, Right(mockStaff));
    });

    test('should register as a customer', () async {
      when(mockFirebaseAuthDataSource.signUpWithPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => mockFirebaseUser);
      when(mockAccountDataSource.getUserProfile(
        id: anyNamed('id'),
      )).thenAnswer((_) async => mockCustomer);

      final result = await repository.registerWithPassword(
        name: nameTest,
        email: emailTest,
        password: passwordTest,
        photoUrl: photoUrlTest,
      );

      verifyInOrder([
        mockFirebaseAuthDataSource.signUpWithPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        ),
        mockFirebaseAuthDataSource.updateProfile(
          updateInfo: anyNamed('updateInfo'),
        ),
        mockFirebaseMessagingDataSource.getDeviceToken(),
        mockAccountDataSource.setUserProfile(
          id: anyNamed('id'),
          deviceToken: anyNamed('deviceToken'),
          name: anyNamed('name'),
          email: anyNamed('email'),
          photoUrl: anyNamed('photoUrl'),
        ),
        mockAccountDataSource.getUserProfile(id: anyNamed('id')),
      ]);
      expect(result, Right(mockCustomer));
    });

    test('should return UnexpectedFailure', () async {
      when(mockFirebaseAuthDataSource.signUpWithPassword(
        email: emailTest,
        password: passwordTest,
      )).thenThrow(UnexpectedException());

      final result = await repository.registerWithPassword(
        name: nameTest,
        email: emailTest,
        password: passwordTest,
      );

      expect((result as Left).value, isA<UnexpectedFailure>());
    });

    test(
      'should call toFailure if exception is AppException',
      () async {
        when(mockAppException.toFailure()).thenReturn(mockFailure);
        when(mockFirebaseAuthDataSource.signUpWithPassword(
          email: emailTest,
          password: passwordTest,
        )).thenThrow(mockAppException);

        final result = await repository.registerWithPassword(
          name: nameTest,
          email: emailTest,
          password: passwordTest,
        );

        expect((result as Left).value, mockFailure);
        expect((result as Left).value, isA<Failure>());
      },
    );

    test('should return UnexpectedFailure', () async {
      when(mockFirebaseAuthDataSource.signUpWithPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => mockFirebaseUser);
      when(mockAccountDataSource.setUserProfile(
        id: anyNamed('id'),
        deviceToken: anyNamed('deviceToken'),
        name: anyNamed('name'),
        email: anyNamed('email'),
      )).thenThrow(UnexpectedException());

      final result = await repository.registerWithPassword(
        name: nameTest,
        email: emailTest,
        password: passwordTest,
      );

      expect((result as Left).value, isA<UnexpectedFailure>());
    });

    test(
      'should call toFailure if exception is AppException',
      () async {
        when(mockFirebaseAuthDataSource.signUpWithPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => mockFirebaseUser);
        when(mockAppException.toFailure()).thenReturn(mockFailure);
        when(mockAccountDataSource.setUserProfile(
          id: anyNamed('id'),
          deviceToken: anyNamed('deviceToken'),
          name: anyNamed('name'),
          email: anyNamed('email'),
        )).thenThrow(mockAppException);

        final result = await repository.registerWithPassword(
          name: nameTest,
          email: emailTest,
          password: passwordTest,
        );

        expect((result as Left).value, mockFailure);
        expect((result as Left).value, isA<Failure>());
      },
    );
  });
  group('logout', () {
    test('should call all dependencies in order', () async {
      when(mockFirebaseAuthDataSource.getCurrentUser())
          .thenAnswer((_) async => mockFirebaseUser);

      await repository.logout();

      verifyInOrder([
        mockFirebaseAuthDataSource.getCurrentUser(),
        mockFirebaseMessagingDataSource.getDeviceToken(),
        mockAccountDataSource.removeDeviceToken(
          id: anyNamed('id'),
          deviceToken: anyNamed('deviceToken'),
        ),
        mockFirebaseAuthDataSource.logout(),
      ]);
    });

    test('should return Right(true)', () async {
      when(mockFirebaseAuthDataSource.getCurrentUser())
          .thenAnswer((_) async => mockFirebaseUser);
      when(mockAccountDataSource.removeDeviceToken(
        id: anyNamed('id'),
        deviceToken: anyNamed('deviceToken'),
      )).thenAnswer((_) async => true);

      final result = await repository.logout();

      expect(result, Right(true));
    });

    test('should return UnexpectedFailure', () async {
      when(mockFirebaseAuthDataSource.getCurrentUser())
          .thenAnswer((_) async => mockFirebaseUser);
      when(mockAccountDataSource.removeDeviceToken(
        id: anyNamed('id'),
        deviceToken: anyNamed('deviceToken'),
      )).thenThrow(UnexpectedException());

      final result = await repository.logout();

      expect((result as Left).value, isA<UnexpectedFailure>());
    });

    test(
      'should call toFailure if exception is AppException',
      () async {
        when(mockFirebaseAuthDataSource.getCurrentUser())
            .thenAnswer((_) async => mockFirebaseUser);
        when(mockAppException.toFailure()).thenReturn(mockFailure);
        when(mockAccountDataSource.removeDeviceToken(
          id: anyNamed('id'),
          deviceToken: anyNamed('deviceToken'),
        )).thenThrow(mockAppException);

        final result = await repository.logout();

        expect((result as Left).value, mockFailure);
        expect((result as Left).value, isA<Failure>());
      },
    );
  });
  group('getBearerToken', () {
    final String idToken = 'idToken';

    test('should return string token', () async {
      when(mockFirebaseAuthDataSource.getCurrentUserIdToken())
          .thenAnswer((_) async => idToken);

      final result = await repository.getBearerToken();

      expect(result, Right(idToken));
    });

    test('should return UnauthorizedFailure', () async {
      when(mockFirebaseAuthDataSource.getCurrentUserIdToken())
          .thenThrow(UnauthorizedException());

      final result = await repository.getBearerToken();

      expect(result, Left(UnauthorizedFailure()));
    });
  });
  group('getUserProfile', () {
    test('should get customer', () async {
      when(mockAccountDataSource.getUserProfile(id: anyNamed('id')))
          .thenAnswer((_) async => mockCustomer);

      final result = await repository.getUserProfile(id: idTest);

      expect(result, Right(mockCustomer));
    });

    test('should get staff', () async {
      when(mockAccountDataSource.getUserProfile(id: anyNamed('id')))
          .thenAnswer((_) async => mockStaff);

      final result = await repository.getUserProfile(id: idTest);

      expect(result, Right(mockStaff));
    });

    test('should return UnexpectedFailure', () async {
      when(mockAccountDataSource.getUserProfile(id: anyNamed('id')))
          .thenThrow(UnexpectedException());

      final result = await repository.getUserProfile(id: idTest);

      expect((result as Left).value, isA<UnexpectedFailure>());
    });

    test(
      'should call toFailure if exception is AppException',
      () async {
        when(mockAppException.toFailure()).thenReturn(mockFailure);
        when(mockAccountDataSource.getUserProfile(id: anyNamed('id')))
            .thenThrow(mockAppException);

        final result = await repository.getUserProfile(id: idTest);

        expect((result as Left).value, mockFailure);
        expect((result as Left).value, isA<Failure>());
      },
    );
  });

  group('updateUserProfile', () {
    final customerFixture = json.decode(
      fixture('fixtures/customers/complete_valid.json'),
    );
    final customer = Customer.fromJson(
      Map<String, dynamic>.from(customerFixture),
    );

    test('should update customer', () async {
      when(mockAccountDataSource.updateUserProfile(
        account: anyNamed('account'),
      )).thenAnswer((_) async => customer);

      final result = await repository.updateUserProfile(account: customer);

      expect(result, Right(customer));
    });

    test('should update staff', () async {
      when(mockAccountDataSource.updateUserProfile(
        account: anyNamed('account'),
      )).thenAnswer((_) async => mockStaff);

      final result = await repository.updateUserProfile(account: mockStaff);

      expect(result, Right(mockStaff));
    });

    test('should return UnexpectedFailure', () async {
      when(mockAccountDataSource.updateUserProfile(
        account: anyNamed('account'),
      )).thenThrow(UnexpectedException());

      final result = await repository.updateUserProfile(account: mockStaff);

      expect((result as Left).value, isA<UnexpectedFailure>());
    });

    test(
      'should call toFailure if exception is AppException',
      () async {
        when(mockAppException.toFailure()).thenReturn(mockFailure);
        when(mockAccountDataSource.updateUserProfile(
          account: anyNamed('account'),
        )).thenThrow(mockAppException);

        final result = await repository.updateUserProfile(account: mockStaff);

        expect((result as Left).value, mockFailure);
        expect((result as Left).value, isA<Failure>());
      },
    );
  });

  group('changePassword', () {
    final passwordTest = 'password';
    final currentPasswordTest = 'currentPassword';

    test('should return true', () async {
      when(mockFirebaseAuthDataSource.checkCurrentPassword(
        currentPassword: anyNamed('currentPassword'),
      )).thenAnswer((_) async => Right(true));
      when(mockFirebaseAuthDataSource.changePassword(
        password: anyNamed('password'),
      )).thenAnswer((_) async => Right(true));

      final result = await repository.changePassword(
        password: passwordTest,
        currentPassword: currentPasswordTest,
      );

      expect(result, Right(true));
    });

    test('should return UnexpectedFailure', () async {
      when(mockFirebaseAuthDataSource.changePassword(
        password: anyNamed('password'),
      )).thenThrow(UnexpectedException());

      final result = await repository.changePassword(
        password: passwordTest,
        currentPassword: currentPasswordTest,
      );

      expect((result as Left).value, isA<UnexpectedFailure>());
    });

    test(
      'should call toFailure if exception is AppException',
      () async {
        when(mockAppException.toFailure()).thenReturn(mockFailure);
        when(mockFirebaseAuthDataSource.changePassword(
          password: anyNamed('password'),
        )).thenThrow(mockAppException);

        final result = await repository.changePassword(
          password: passwordTest,
          currentPassword: currentPasswordTest,
        );

        expect((result as Left).value, mockFailure);
        expect((result as Left).value, isA<Failure>());
      },
    );
  });

  group('resetPassword', () {
    final emailTest = 'john@doe.com';

    test('should return true', () async {
      when(mockFirebaseAuthDataSource.resetPassword(
        email: anyNamed('email'),
      )).thenAnswer((_) async => Right(true));

      final result = await repository.resetPassword(email: emailTest);

      expect(result, Right(true));
    });

    test('should return UnexpectedFailure', () async {
      when(mockFirebaseAuthDataSource.resetPassword(
        email: anyNamed('email'),
      )).thenThrow(UnexpectedException());

      final result = await repository.resetPassword(email: emailTest);

      expect((result as Left).value, isA<UnexpectedFailure>());
    });

    test(
      'should call toFailure if exception is AppException',
      () async {
        when(mockAppException.toFailure()).thenReturn(mockFailure);
        when(mockFirebaseAuthDataSource.resetPassword(
          email: anyNamed('email'),
        )).thenThrow(mockAppException);

        final result = await repository.resetPassword(email: emailTest);

        expect((result as Left).value, mockFailure);
        expect((result as Left).value, isA<Failure>());
      },
    );
  });

  group('autoLogin', () {
    final deviceTokenTest = 'token';

    test('should get customer', () async {
      when(mockFirebaseAuthDataSource.getCurrentUser()).thenAnswer(
        (_) async => mockFirebaseUser,
      );
      when(mockFirebaseMessagingDataSource.getDeviceToken()).thenAnswer(
        (_) async => deviceTokenTest,
      );
      when(mockAccountDataSource.getUserProfile(
        id: anyNamed('id'),
      )).thenAnswer((_) async => mockCustomer);

      final result = await repository.autoLogin();

      verifyInOrder([
        mockFirebaseAuthDataSource.getCurrentUser(),
        mockFirebaseMessagingDataSource.getDeviceToken(),
        mockAccountDataSource.getUserProfile(id: anyNamed('id')),
      ]);
      expect(result, Right(mockCustomer));
    });

    test('should get staff', () async {
      when(mockFirebaseAuthDataSource.getCurrentUser()).thenAnswer(
        (_) async => mockFirebaseUser,
      );
      when(mockFirebaseMessagingDataSource.getDeviceToken()).thenAnswer(
        (_) async => deviceTokenTest,
      );
      when(mockAccountDataSource.getUserProfile(
        id: anyNamed('id'),
      )).thenAnswer((_) async => mockStaff);

      final result = await repository.autoLogin();

      verifyInOrder([
        mockFirebaseAuthDataSource.getCurrentUser(),
        mockFirebaseMessagingDataSource.getDeviceToken(),
        mockAccountDataSource.getUserProfile(id: anyNamed('id')),
      ]);
      expect(result, Right(mockStaff));
    });

    test('should return UnauthorizedFailure', () async {
      when(mockFirebaseAuthDataSource.getCurrentUser()).thenAnswer(
        (_) async => null,
      );

      final result = await repository.autoLogin();

      expect((result as Left).value, isA<UnauthorizedFailure>());
    });

    test('should return UnauthorizedFailure', () async {
      when(mockFirebaseAuthDataSource.getCurrentUser()).thenAnswer(
        (_) async => mockFirebaseUser,
      );
      when(mockFirebaseMessagingDataSource.getDeviceToken()).thenAnswer(
        (_) async => null,
      );

      final result = await repository.autoLogin();

      expect((result as Left).value, isA<UnauthorizedFailure>());
    });

    test('should return UnexpectedFailure', () async {
      when(mockFirebaseAuthDataSource.getCurrentUser()).thenAnswer(
        (_) async => mockFirebaseUser,
      );
      when(mockFirebaseMessagingDataSource.getDeviceToken()).thenAnswer(
        (_) async => deviceTokenTest,
      );
      when(mockAccountDataSource.getUserProfile(id: anyNamed('id'))).thenThrow(
        UnexpectedException(),
      );

      final result = await repository.autoLogin();

      expect((result as Left).value, isA<UnexpectedFailure>());
    });

    test(
      'should call toFailure if exception is AppException',
      () async {
        when(mockAppException.toFailure()).thenReturn(mockFailure);
        when(mockFirebaseAuthDataSource.getCurrentUser()).thenAnswer(
          (_) async => mockFirebaseUser,
        );
        when(mockFirebaseMessagingDataSource.getDeviceToken()).thenAnswer(
          (_) async => deviceTokenTest,
        );
        when(mockAccountDataSource.getUserProfile(
          id: anyNamed('id'),
        )).thenThrow(mockAppException);

        final result = await repository.autoLogin();

        expect((result as Left).value, mockFailure);
        expect((result as Left).value, isA<Failure>());
      },
    );
  });

  group('getUsers', () {
    final usersTest = [mockStaff, mockCustomer];
    test('should get list of users', () async {
      when(mockFirebaseRealtimeDataSource.getUsers()).thenAnswer(
        (_) async => usersTest,
      );

      final result = await repository.getUsers();

      verify(mockFirebaseRealtimeDataSource.getUsers());
      expect(result, Right(usersTest));
    });

    test('should return UnexpectedFailure', () async {
      when(mockFirebaseRealtimeDataSource.getUsers()).thenThrow(
        UnexpectedException(),
      );

      final result = await repository.getUsers();

      expect((result as Left).value, isA<UnexpectedFailure>());
    });

    test(
      'should call toFailure if exception is AppException',
      () async {
        when(mockAppException.toFailure()).thenReturn(mockFailure);
        when(mockFirebaseRealtimeDataSource.getUsers()).thenThrow(
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
      when(mockFirebaseRealtimeDataSource.getUsersData()).thenAnswer(
        (_) async => usersDataTest,
      );

      final result = await repository.getUsersData();

      verify(mockFirebaseRealtimeDataSource.getUsersData());
      expect(result, Right(usersDataTest));
    });

    test('should return UnexpectedFailure', () async {
      when(mockFirebaseRealtimeDataSource.getUsersData()).thenThrow(
        Exception(),
      );

      final result = await repository.getUsersData();

      expect((result as Left).value, isA<UnexpectedFailure>());
    });

    test(
      'should call toFailure if exception is AppException',
      () async {
        when(mockAppException.toFailure()).thenReturn(mockFailure);
        when(mockFirebaseRealtimeDataSource.getUsersData()).thenThrow(
          mockAppException,
        );

        final result = await repository.getUsersData();

        expect((result as Left).value, mockFailure);
        expect((result as Left).value, isA<Failure>());
      },
    );
  });
}
