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
    setUpFirebaseAuthLoginThrowException(Exception exception) {
      when(mockFirebaseAuthDataSource.signInWithPassword(
        email: emailTest,
        password: passwordTest,
      )).thenThrow(exception);
    }

    setUpAccountLoginThrowException(Exception exception) {
      when(mockAccountDataSource.setUserProfile(
        id: anyNamed('id'),
        deviceToken: anyNamed('deviceToken'),
      )).thenThrow(exception);
    }

    test('should login as a staff', () async {
      when(mockAccountDataSource.setUserProfile(
        id: anyNamed('id'),
        deviceToken: anyNamed('deviceToken'),
      )).thenAnswer((_) async => mockStaff);

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signInWithPassword(
          email: emailTest, password: passwordTest));
      verify(mockFirebaseMessagingDataSource.getDeviceToken());
      verifyNever(mockAccountDataSource.setUserProfile(
        id: idTest,
        deviceToken: deviceTokenTest,
      ));
      expect(result, Right(mockStaff));
    });

    test('should login as a customer', () async {
      when(mockAccountDataSource.setUserProfile(
        id: anyNamed('id'),
        deviceToken: anyNamed('deviceToken'),
      )).thenAnswer((_) async => mockCustomer);

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signInWithPassword(
          email: emailTest, password: passwordTest));
      verify(mockFirebaseMessagingDataSource.getDeviceToken());
      verifyNever(mockAccountDataSource.setUserProfile(
        id: idTest,
        deviceToken: deviceTokenTest,
      ));
      expect(result, Right(mockCustomer));
    });

    test('should return InvalidEmailFailure', () async {
      setUpFirebaseAuthLoginThrowException(InvalidEmailException());

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signInWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<InvalidEmailFailure>());
    });

    test('should return WrongPasswordFailure', () async {
      setUpFirebaseAuthLoginThrowException(WrongPasswordException());

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signInWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<WrongPasswordFailure>());
    });

    test('should return UserNotFoundFailure', () async {
      setUpFirebaseAuthLoginThrowException(UserNotFoundException());

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signInWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<UserNotFoundFailure>());
    });

    test('should return UserDisabledFailure', () async {
      setUpFirebaseAuthLoginThrowException(UserDisabledException());

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signInWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<UserDisabledFailure>());
    });

    test('should return TooManyRequestsFailure', () async {
      setUpFirebaseAuthLoginThrowException(TooManyRequestsException());

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signInWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<TooManyRequestsFailure>());
    });

    test('should return OperationNotAllowedFailure', () async {
      setUpFirebaseAuthLoginThrowException(OperationNotAllowedException());

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signInWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<OperationNotAllowedFailure>());
    });

    test('should return UndefinedFirebaseAuthFailure', () async {
      setUpFirebaseAuthLoginThrowException(UndefinedFirebaseAuthException());

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signInWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<UndefinedFirebaseAuthFailure>());
    });

    test('should return BadRequestFailure', () async {
      setUpAccountLoginThrowException(BadRequestException());

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signInWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<BadRequestFailure>());
    });

    test('should return InternalServerErrorFailure', () async {
      setUpAccountLoginThrowException(InternalServerErrorException());

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signInWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<InternalServerErrorFailure>());
    });

    test('should return ServiceUnavailableFailure', () async {
      setUpAccountLoginThrowException(ServiceUnavailableException());

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signInWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<ServiceUnavailableFailure>());
    });

    test('should return PreconditionFailedFailure', () async {
      setUpAccountLoginThrowException(PreconditionFailedException());

      final result = await repository.loginWithPassword(
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signInWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<PreconditionFailedFailure>());
    });
  });
  group('registerWithPassword', () {
    final nameTest = 'John Doe';

    setUpFirebaseAuthRegisterThrowException(Exception exception) {
      when(mockFirebaseAuthDataSource.signUpWithPassword(
        email: emailTest,
        password: passwordTest,
      )).thenThrow(exception);
    }

    setUpAccountRegisterThrowException(Exception exception) {
      when(mockAccountDataSource.setUserProfile(
        id: anyNamed('id'),
        deviceToken: anyNamed('deviceToken'),
        name: anyNamed('name'),
        email: anyNamed('email'),
      )).thenThrow(exception);
    }

    test('should register as a customer', () async {
      when(mockAccountDataSource.setUserProfile(
        id: anyNamed('id'),
        deviceToken: anyNamed('deviceToken'),
        name: anyNamed('name'),
        email: anyNamed('email'),
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
      verifyNever(mockAccountDataSource.setUserProfile(
        id: idTest,
        deviceToken: deviceTokenTest,
        name: nameTest,
        email: emailTest,
      ));
      expect(result, Right(mockStaff));
    });

    test('should register as a customer', () async {
      when(mockAccountDataSource.setUserProfile(
        id: anyNamed('id'),
        deviceToken: anyNamed('deviceToken'),
        name: anyNamed('name'),
        email: anyNamed('email'),
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
      verifyNever(mockAccountDataSource.setUserProfile(
        id: idTest,
        deviceToken: deviceTokenTest,
        name: nameTest,
        email: emailTest,
      ));
      expect(result, Right(mockCustomer));
    });

    test('should return InvalidEmailFailure', () async {
      setUpFirebaseAuthRegisterThrowException(InvalidEmailException());

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
      setUpFirebaseAuthRegisterThrowException(WeakPasswordException());

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
      setUpFirebaseAuthRegisterThrowException(EmailAlreadyInUseException());

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
      setUpFirebaseAuthRegisterThrowException(UndefinedFirebaseAuthException());

      final result = await repository.registerWithPassword(
        name: nameTest,
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signUpWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<UndefinedFirebaseAuthFailure>());
    });

    test('should return BadRequestFailure', () async {
      setUpAccountRegisterThrowException(BadRequestException());

      final result = await repository.registerWithPassword(
        name: nameTest,
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signUpWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<BadRequestFailure>());
    });

    test('should return InternalServerErrorFailure', () async {
      setUpAccountRegisterThrowException(InternalServerErrorException());

      final result = await repository.registerWithPassword(
        name: nameTest,
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signUpWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<InternalServerErrorFailure>());
    });

    test('should return ServiceUnavailableFailure', () async {
      setUpAccountRegisterThrowException(ServiceUnavailableException());

      final result = await repository.registerWithPassword(
        name: nameTest,
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signUpWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<ServiceUnavailableFailure>());
    });

    test('should return PreconditionFailedFailure', () async {
      setUpAccountRegisterThrowException(PreconditionFailedException());

      final result = await repository.registerWithPassword(
        name: nameTest,
        email: emailTest,
        password: passwordTest,
      );

      verify(mockFirebaseAuthDataSource.signUpWithPassword(
          email: emailTest, password: passwordTest));
      expect((result as Left).value, isA<PreconditionFailedFailure>());
    });
  });
  group('logout', () {
    setUpAccountLogoutThrowException(Exception exception) {
      when(mockAccountDataSource.removeDeviceToken(
        id: anyNamed('id'),
        deviceToken: anyNamed('deviceToken'),
      )).thenThrow(exception);
    }

    test('should call all dependencies in order', () async {
      await repository.logout();

      verifyInOrder([
        mockFirebaseAuthDataSource.getCurrentUserId(),
        mockFirebaseMessagingDataSource.getDeviceToken(),
        mockAccountDataSource.removeDeviceToken(
          id: anyNamed('id'),
          deviceToken: anyNamed('deviceToken'),
        ),
        mockFirebaseAuthDataSource.logout(),
      ]);
    });

    test('should return Right(true)', () async {
      when(mockAccountDataSource.removeDeviceToken(
        id: anyNamed('id'),
        deviceToken: anyNamed('deviceToken'),
      )).thenAnswer((_) async => true);

      final result = await repository.logout();

      expect(result, Right(true));
    });

    test('should return Left(InvalidIdTokenFailure())', () async {
      setUpAccountLogoutThrowException(InvalidIdTokenException());

      final result = await repository.logout();

      expect(result, Left(InvalidIdTokenFailure()));
    });

    test('should return Left(NotFoundFailure())', () async {
      setUpAccountLogoutThrowException(NotFoundException());

      final result = await repository.logout();

      expect(result, Left(NotFoundFailure()));
    });

    test('should return Left(BadRequestFailure())', () async {
      setUpAccountLogoutThrowException(BadRequestException());

      final result = await repository.logout();

      expect(result, Left(BadRequestFailure()));
    });

    test('should return Left(InternalServerErrorFailure())', () async {
      setUpAccountLogoutThrowException(InternalServerErrorException());

      final result = await repository.logout();

      expect(result, Left(InternalServerErrorFailure()));
    });

    test('should return Left(ServiceUnavailableFailure())', () async {
      setUpAccountLogoutThrowException(ServiceUnavailableException());

      final result = await repository.logout();

      expect(result, Left(ServiceUnavailableFailure()));
    });

    test('should return Left(PreconditionFailedFailure())', () async {
      setUpAccountLogoutThrowException(PreconditionFailedException());

      final result = await repository.logout();

      expect(result, Left(PreconditionFailedFailure()));
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

    test('should return BadRequestFailure', () async {
      when(mockAccountDataSource.getUserProfile(id: anyNamed('id')))
          .thenThrow(BadRequestException());
      final result = await repository.getUserProfile(id: idTest);
      expect(result, Left(BadRequestFailure()));
    });

    test('should return internalServerErrorFailure', () async {
      when(mockAccountDataSource.getUserProfile(id: anyNamed('id')))
          .thenThrow(InternalServerErrorException());
      final result = await repository.getUserProfile(id: idTest);
      expect(result, Left(InternalServerErrorFailure()));
    });

    test('should return ServiceUnavailableFailure', () async {
      when(mockAccountDataSource.getUserProfile(id: anyNamed('id')))
          .thenThrow(ServiceUnavailableException());
      final result = await repository.getUserProfile(id: idTest);
      expect(result, Left(ServiceUnavailableFailure()));
    });

    test('should return PreconditionFailedFailure', () async {
      when(mockAccountDataSource.getUserProfile(id: anyNamed('id')))
          .thenThrow(PreconditionFailedException());
      final result = await repository.getUserProfile(id: idTest);
      expect(result, Left(PreconditionFailedFailure()));
    });
  });

  group('changePassword', () {
    final passwordTest = 'password';
    final oldPasswordTest = 'oldPassword';

    setUpThrowException(Exception exception) {
      when(mockFirebaseAuthDataSource.changePassword(
        password: anyNamed('password'),
      )).thenThrow(exception);
    }

    test('should return true', () async {
      when(mockFirebaseAuthDataSource.changePassword(
        password: anyNamed('password'),
      )).thenAnswer((_) async => Right(true));

      final result = await repository.changePassword(
        password: passwordTest,
        oldPassword: oldPasswordTest,
      );

      expect(result, Right(true));
    });

    test('should return UserDisabledFailure', () async {
      setUpThrowException(UserDisabledException());

      final result = await repository.changePassword(
        password: passwordTest,
        oldPassword: oldPasswordTest,
      );

      expect(result, Left(UserDisabledFailure()));
    });

    test('should return WeakPasswordFailure', () async {
      setUpThrowException(WeakPasswordException());

      final result = await repository.changePassword(
        password: passwordTest,
        oldPassword: oldPasswordTest,
      );

      expect(result, Left(WeakPasswordFailure()));
    });

    test('should return UndefinedFirebaseAuthFailure', () async {
      setUpThrowException(UndefinedFirebaseAuthException());

      final result = await repository.changePassword(
        password: passwordTest,
        oldPassword: oldPasswordTest,
      );

      expect(result, Left(UndefinedFirebaseAuthFailure()));
    });
  });

  group('resetPassword', () {
    final emailTest = 'john@doe.com';

    setUpThrowException(Exception exception) {
      when(mockFirebaseAuthDataSource.resetPassword(
        email: anyNamed('email'),
      )).thenThrow(exception);
    }

    test('should return true', () async {
      when(mockFirebaseAuthDataSource.resetPassword(
        email: anyNamed('email'),
      )).thenAnswer((_) async => Right(true));

      final result = await repository.resetPassword(
        email: emailTest,
      );

      expect(result, Right(true));
    });

    test('should return UserNotFoundFailure', () async {
      setUpThrowException(UserNotFoundException());

      final result = await repository.resetPassword(
        email: emailTest,
      );

      expect(result, Left(UserNotFoundFailure()));
    });

    test('should return UndefinedFirebaseAuthFailure', () async {
      setUpThrowException(UndefinedFirebaseAuthException());

      final result = await repository.resetPassword(
        email: emailTest,
      );

      expect(result, Left(UndefinedFirebaseAuthFailure()));
    });
  });
}
