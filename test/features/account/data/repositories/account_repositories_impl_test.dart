import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/exception.dart';
import 'package:flutter_architecture/core/error/failure.dart';
import 'package:flutter_architecture/features/account/data/data_sources/account_data_source.dart';
import 'package:flutter_architecture/features/account/data/data_sources/firebase_auth_data_source.dart';
import 'package:flutter_architecture/features/account/data/data_sources/firebase_messaging_data_source.dart';
import 'package:flutter_architecture/features/account/data/repositories/account_repository_impl.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAccountDataSource extends Mock implements AccountDataSource {}

class MockFirebaseAuthDataSource extends Mock
    implements FirebaseAuthDataSource {}

class MockFirebaseMessagingDataSource extends Mock
    implements FirebaseMessagingDataSource {}

// ignore: must_be_immutable
class MockStaff extends Mock implements Staff {}

// ignore: must_be_immutable
class MockCustomer extends Mock implements Customer {}

void main() {
  AccountRepositoryImpl repository;
  MockAccountDataSource mockAccountDataSource;
  MockFirebaseAuthDataSource mockFirebaseAuthDataSource;
  MockFirebaseMessagingDataSource mockFirebaseMessagingDataSource;

  MockStaff mockStaff;
  MockCustomer mockCustomer;

  setUp(() {
    mockAccountDataSource = MockAccountDataSource();
    mockFirebaseAuthDataSource = MockFirebaseAuthDataSource();
    mockFirebaseMessagingDataSource = MockFirebaseMessagingDataSource();
    repository = AccountRepositoryImpl(
      accountDataSource: mockAccountDataSource,
      firebaseAuthDataSource: mockFirebaseAuthDataSource,
      firebaseMessagingDataSource: mockFirebaseMessagingDataSource,
    );

    mockStaff = MockStaff();
    mockCustomer = MockCustomer();
  });

  final idTest = 'user_uid';
  final deviceTokenTest = 'mockdevicetoken';

  final emailTest = 'test';
  final passwordTest = 'test';

  group('loginWithPassword', () {
    setUpLoginThrowException(Exception exception) {
      when(mockAccountDataSource.getUserProfile(
        id: anyNamed('id'),
      )).thenThrow(exception);
    }

    test('should login as a staff', () async {
      when(mockAccountDataSource.getUserProfile(
        id: anyNamed('id'),
      )).thenAnswer((_) async => mockStaff);

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signInWithPassword(
          email: emailTest, password: passwordTest));
      verify(mockFirebaseMessagingDataSource.getDeviceToken());
      verifyNever(mockAccountDataSource.getUserProfile(id: idTest));
      verifyNever(mockAccountDataSource.setDeviceToken(
          deviceToken: deviceTokenTest, id: idTest));
      expect(result, Right(mockStaff));
    });

    test('should login as a customer', () async {
      when(mockAccountDataSource.getUserProfile(
        id: anyNamed('id'),
      )).thenAnswer((_) async => mockCustomer);

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signInWithPassword(
          email: emailTest, password: passwordTest));
      verify(mockFirebaseMessagingDataSource.getDeviceToken());
      verifyNever(mockAccountDataSource.getUserProfile(id: idTest));
      verifyNever(mockAccountDataSource.setDeviceToken(
          deviceToken: deviceTokenTest, id: idTest));
      expect(result, Right(mockCustomer));
    });

    test('should return InvalidEmailFailure', () async {
      setUpLoginThrowException(InvalidEmailException());

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signInWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<InvalidEmailFailure>());
    });

    test('should return WrongPasswordFailure', () async {
      setUpLoginThrowException(WrongPasswordException());

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signInWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<WrongPasswordFailure>());
    });

    test('should return UserNotFoundFailure', () async {
      setUpLoginThrowException(UserNotFoundException());

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signInWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<UserNotFoundFailure>());
    });

    test('should return UserDisabledFailure', () async {
      setUpLoginThrowException(UserDisabledException());

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signInWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<UserDisabledFailure>());
    });

    test('should return TooManyRequestsFailure', () async {
      setUpLoginThrowException(TooManyRequestsException());

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signInWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<TooManyRequestsFailure>());
    });

    test('should return OperationNotAllowedFailure', () async {
      setUpLoginThrowException(OperationNotAllowedException());

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signInWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<OperationNotAllowedFailure>());
    });

    test('should return UndefinedFirebaseAuthFailure', () async {
      setUpLoginThrowException(UndefinedFirebaseAuthException());

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signInWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<UndefinedFirebaseAuthFailure>());
    });
  });
  group('registerWithPassword', () {
    final nameTest = 'John Doe';

    setUpRegisterThrowException(Exception exception) {
      when(mockAccountDataSource.getUserProfile(
        id: anyNamed('id'),
      )).thenThrow(exception);
    }

    test('should register as a customer', () async {
      when(mockAccountDataSource.getUserProfile(
        id: anyNamed('id'),
      )).thenAnswer((_) async => mockStaff);

      final result = await repository.registerWithPassword(
        name: nameTest,
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signUpWithPassword(
          email: emailTest, password: passwordTest));
      verify(mockFirebaseAuthDataSource.updateProfile(
          updateInfo: anyNamed('updateInfo')));
      verify(mockFirebaseMessagingDataSource.getDeviceToken());
      verifyNever(mockAccountDataSource.getUserProfile(id: idTest));
      verifyNever(mockAccountDataSource.setDeviceToken(
          deviceToken: deviceTokenTest, id: idTest));
      expect(result, Right(mockStaff));
    });

    test('should register as a customer', () async {
      when(mockAccountDataSource.getUserProfile(
        id: anyNamed('id'),
      )).thenAnswer((_) async => mockCustomer);

      final result = await repository.registerWithPassword(
        name: nameTest,
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signUpWithPassword(
          email: emailTest, password: passwordTest));
      verify(mockFirebaseAuthDataSource.updateProfile(
          updateInfo: anyNamed('updateInfo')));
      verify(mockFirebaseMessagingDataSource.getDeviceToken());
      verifyNever(mockAccountDataSource.getUserProfile(id: idTest));
      verifyNever(mockAccountDataSource.setDeviceToken(
          deviceToken: deviceTokenTest, id: idTest));
      expect(result, Right(mockCustomer));
    });

    test('should return InvalidEmailFailure', () async {
      setUpRegisterThrowException(InvalidEmailException());

      final result = await repository.registerWithPassword(
        name: nameTest,
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signUpWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<InvalidEmailFailure>());
    });

    test('should return WeakPasswordFailure', () async {
      setUpRegisterThrowException(WeakPasswordException());

      final result = await repository.registerWithPassword(
        name: nameTest,
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signUpWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<WeakPasswordFailure>());
    });

    test('should return EmailAlreadyInUseFailure', () async {
      setUpRegisterThrowException(EmailAlreadyInUseException());

      final result = await repository.registerWithPassword(
        name: nameTest,
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signUpWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<EmailAlreadyInUseFailure>());
    });

    test('should return UndefinedFirebaseAuthFailure', () async {
      setUpRegisterThrowException(UndefinedFirebaseAuthException());

      final result = await repository.registerWithPassword(
        name: nameTest,
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signUpWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<UndefinedFirebaseAuthFailure>());
    });
  });
  group('logout', () {
    test('should call all dependencies in order', () async {
      await repository.logout();

      verifyInOrder([
        mockFirebaseMessagingDataSource.getDeviceToken(),
        mockAccountDataSource.removeDeviceToken(
            deviceToken: anyNamed('deviceToken')),
        mockFirebaseAuthDataSource.logout(),
      ]);
    });

    test('should return Right(true)', () async {
      when(mockAccountDataSource.removeDeviceToken(
        deviceToken: anyNamed('deviceToken'),
      )).thenAnswer((_) async => true);

      final result = await repository.logout();

      expect(result, Right(true));
    });

    test('should return Left(InvalidIdTokenFailure())', () async {
      when(mockAccountDataSource.removeDeviceToken(
        deviceToken: anyNamed('deviceToken'),
      )).thenThrow(InvalidIdTokenException());

      final result = await repository.logout();

      expect(result, Left(InvalidIdTokenFailure()));
    });
  });
  group('getBearerToken', () {
    final String idToken = 'idToken';

    test('should return string token', () async {
      when(mockFirebaseAuthDataSource.getCurrentUserIdToken())
          .thenAnswer((_) async => idToken);

      final result = await repository.getBearerToken();

      expect(result, Right(idToken));
    });

    test('should return UnauthenticatedFailure', () async {
      when(mockFirebaseAuthDataSource.getCurrentUserIdToken())
          .thenThrow(UnauthenticatedException());

      final result = await repository.getBearerToken();

      expect(result, Left(UnauthenticatedFailure()));
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

    test('should return NotFoundFailure', () async {
      when(mockAccountDataSource.getUserProfile(id: anyNamed('id')))
          .thenThrow(NotFoundException());
      final result = await repository.getUserProfile(id: idTest);
      expect(result, Left(NotFoundFailure()));
    });

    test('should return UnimplementedError', () async {
      when(mockAccountDataSource.getUserProfile(id: anyNamed('id')))
          .thenThrow(UnimplementedError());

      final result = await repository.getUserProfile(id: idTest);

      expect(result, Left(UnexpectedFailure()));
    });
  });
}
