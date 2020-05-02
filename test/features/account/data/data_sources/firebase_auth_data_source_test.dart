import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_architecture/core/error/exception.dart';
import 'package:flutter_architecture/features/account/data/data_sources/firebase_auth_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockAuthResult extends Mock implements AuthResult {}

class MockFirebaseUser extends Mock implements FirebaseUser {}

class MockIdTokenResult extends Mock implements IdTokenResult {}

void main() {
  FirebaseAuthDataSourceImpl dataSource;
  MockFirebaseAuth mockFirebaseAuth;
  MockFirebaseUser mockFirebaseUser;
  MockAuthResult mockAuthResult;
  MockIdTokenResult mockIdTokenResult;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockAuthResult = MockAuthResult();
    mockFirebaseUser = MockFirebaseUser();
    mockIdTokenResult = MockIdTokenResult();
    dataSource =
        FirebaseAuthDataSourceImpl(firebaseAuthInstance: mockFirebaseAuth);
  });

  final emailTest = 'john@doe.com';
  final passwordTest = '123456';

  group('signInWithPassword', () {
    setUpSignInThrowException(Exception exception) {
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: emailTest,
        password: passwordTest,
      )).thenThrow(exception);
    }

    test('should return FirebaseUser', () async {
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: emailTest,
        password: passwordTest,
      )).thenAnswer((_) async => mockAuthResult);
      when(mockAuthResult.user).thenReturn(mockFirebaseUser);

      final result = await dataSource.signInWithPassword(
          email: emailTest, password: passwordTest);

      verify(mockFirebaseAuth.signInWithEmailAndPassword(
          email: emailTest, password: passwordTest));
      verify(mockAuthResult.user);
      expect(result, mockFirebaseUser);
    });

    test('should throw InvalidEmailException', () async {
      setUpSignInThrowException(InvalidEmailException());

      expect(
        () => dataSource.signInWithPassword(
          email: emailTest,
          password: passwordTest,
        ),
        throwsA(isA<InvalidEmailException>()),
      );
      verify(mockFirebaseAuth.signInWithEmailAndPassword(
          email: emailTest, password: passwordTest));
    });

    test('should throw WrongPasswordException', () async {
      setUpSignInThrowException(WrongPasswordException());

      expect(
        () => dataSource.signInWithPassword(
          email: emailTest,
          password: passwordTest,
        ),
        throwsA(isA<WrongPasswordException>()),
      );
      verify(mockFirebaseAuth.signInWithEmailAndPassword(
          email: emailTest, password: passwordTest));
    });

    test('should throw UserNotFoundException', () async {
      setUpSignInThrowException(UserNotFoundException());

      expect(
        () => dataSource.signInWithPassword(
          email: emailTest,
          password: passwordTest,
        ),
        throwsA(isA<UserNotFoundException>()),
      );
      verify(mockFirebaseAuth.signInWithEmailAndPassword(
          email: emailTest, password: passwordTest));
    });

    test('should throw UserDisabledException', () async {
      setUpSignInThrowException(UserDisabledException());

      expect(
        () => dataSource.signInWithPassword(
          email: emailTest,
          password: passwordTest,
        ),
        throwsA(isA<UserDisabledException>()),
      );
      verify(mockFirebaseAuth.signInWithEmailAndPassword(
          email: emailTest, password: passwordTest));
    });

    test('should throw TooManyRequestsException', () async {
      setUpSignInThrowException(TooManyRequestsException());

      expect(
        () => dataSource.signInWithPassword(
          email: emailTest,
          password: passwordTest,
        ),
        throwsA(isA<TooManyRequestsException>()),
      );
      verify(mockFirebaseAuth.signInWithEmailAndPassword(
          email: emailTest, password: passwordTest));
    });

    test('should throw OperationNotAllowedException', () async {
      setUpSignInThrowException(OperationNotAllowedException());

      expect(
        () => dataSource.signInWithPassword(
          email: emailTest,
          password: passwordTest,
        ),
        throwsA(isA<OperationNotAllowedException>()),
      );
      verify(mockFirebaseAuth.signInWithEmailAndPassword(
          email: emailTest, password: passwordTest));
    });

    test('should throw UndefinedFirebaseAuthException', () async {
      setUpSignInThrowException(UndefinedFirebaseAuthException());

      expect(
        () => dataSource.signInWithPassword(
          email: emailTest,
          password: passwordTest,
        ),
        throwsA(isA<UndefinedFirebaseAuthException>()),
      );
      verify(mockFirebaseAuth.signInWithEmailAndPassword(
          email: emailTest, password: passwordTest));
    });
  });
  group('signUpWithPassword', () {
    setUpSignUpThrowException(Exception exception) {
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: emailTest,
        password: passwordTest,
      )).thenThrow(exception);
    }

    test('should return FirebaseUser', () async {
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: emailTest,
        password: passwordTest,
      )).thenAnswer((_) async => mockAuthResult);
      when(mockAuthResult.user).thenReturn(mockFirebaseUser);

      final result = await dataSource.signUpWithPassword(
          email: emailTest, password: passwordTest);

      verify(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: emailTest, password: passwordTest));
      verify(mockAuthResult.user);
      expect(result, mockFirebaseUser);
    });

    test('should throw InvalidEmailException', () async {
      setUpSignUpThrowException(InvalidEmailException());

      expect(
        () => dataSource.signUpWithPassword(
          email: emailTest,
          password: passwordTest,
        ),
        throwsA(isA<InvalidEmailException>()),
      );
      verify(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: emailTest, password: passwordTest));
    });

    test('should throw WeakPasswordException', () async {
      setUpSignUpThrowException(WeakPasswordException());

      expect(
        () => dataSource.signUpWithPassword(
          email: emailTest,
          password: passwordTest,
        ),
        throwsA(isA<WeakPasswordException>()),
      );
      verify(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: emailTest, password: passwordTest));
    });

    test('should throw EmailAlreadyInUseException', () async {
      setUpSignUpThrowException(EmailAlreadyInUseException());

      expect(
        () => dataSource.signUpWithPassword(
          email: emailTest,
          password: passwordTest,
        ),
        throwsA(isA<EmailAlreadyInUseException>()),
      );
      verify(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: emailTest, password: passwordTest));
    });

    test('should throw UndefinedFirebaseAuthException', () async {
      setUpSignUpThrowException(UndefinedFirebaseAuthException());

      expect(
        () => dataSource.signUpWithPassword(
          email: emailTest,
          password: passwordTest,
        ),
        throwsA(isA<UndefinedFirebaseAuthException>()),
      );
      verify(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: emailTest, password: passwordTest));
    });
  });
  group('updateProfile', () {
    final displayName = 'John Doe';
    final photoUrl = 'https://fakeimage.com/image.jpg';
    UserUpdateInfo updateInfo;

    setUp(() {
      updateInfo = UserUpdateInfo();
      updateInfo.displayName = displayName;
      updateInfo.photoUrl = photoUrl;
    });

    test('should update profile successfully', () async {
      when(mockFirebaseAuth.currentUser())
          .thenAnswer((_) async => mockFirebaseUser);

      await dataSource.updateProfile(updateInfo: updateInfo);
      verify(mockFirebaseAuth.currentUser());
      verify(mockFirebaseUser.updateProfile(updateInfo));
    });

    test('should throw UserDisabledException', () async {
      when(mockFirebaseAuth.currentUser()).thenThrow(UserDisabledException());

      expect(
        () => dataSource.updateProfile(updateInfo: updateInfo),
        throwsA(isA<UserDisabledException>()),
      );
      verify(mockFirebaseAuth.currentUser());
    });

    test('should throw UserNotFoundException', () async {
      when(mockFirebaseAuth.currentUser()).thenThrow(UserNotFoundException());

      expect(
        () => dataSource.updateProfile(updateInfo: updateInfo),
        throwsA(isA<UserNotFoundException>()),
      );
      verify(mockFirebaseAuth.currentUser());
    });

    test('should throw UndefinedFirebaseAuthException', () async {
      when(mockFirebaseAuth.currentUser())
          .thenThrow(UndefinedFirebaseAuthException());

      expect(
        () => dataSource.updateProfile(updateInfo: updateInfo),
        throwsA(isA<UndefinedFirebaseAuthException>()),
      );
      verify(mockFirebaseAuth.currentUser());
    });
  });
  group('getCurrentUserIdToken', () {
    final idTokenTest = 'idToken';
    test('should return token', () async {
      when(mockFirebaseAuth.currentUser())
          .thenAnswer((_) async => mockFirebaseUser);
      when(mockFirebaseUser.getIdToken())
          .thenAnswer((_) async => mockIdTokenResult);
      when(mockIdTokenResult.token).thenReturn(idTokenTest);

      final result = await dataSource.getCurrentUserIdToken();

      expect(result, idTokenTest);
      verify(mockFirebaseAuth.currentUser());
      verify(mockFirebaseUser.getIdToken());
      verify(mockIdTokenResult.token);
    });

    test('should return UnauthenticatedException', () async {
      when(mockFirebaseAuth.currentUser()).thenAnswer((_) async => null);

      expect(
        () => dataSource.getCurrentUserIdToken(),
        throwsA(isA<UnauthenticatedException>()),
      );
      verify(mockFirebaseAuth.currentUser());
      verifyNoMoreInteractions(mockFirebaseAuth);
    });
  });

  group('getCurrentUserId', () {
    final idTest = 'id';
    test('should return id', () async {
      when(mockFirebaseAuth.currentUser())
          .thenAnswer((_) async => mockFirebaseUser);
      when(mockFirebaseUser.uid).thenReturn(idTest);

      final result = await dataSource.getCurrentUserId();

      expect(result, idTest);
      verify(mockFirebaseAuth.currentUser());
      verify(mockFirebaseUser.uid);
    });

    test('should return UnauthenticatedException', () async {
      when(mockFirebaseAuth.currentUser()).thenAnswer((_) async => null);

      expect(
        () => dataSource.getCurrentUserId(),
        throwsA(isA<UnauthenticatedException>()),
      );
      verify(mockFirebaseAuth.currentUser());
      verifyNoMoreInteractions(mockFirebaseAuth);
    });
  });

  group('logout', () {
    test('should call FirebaseAuthInstance signOut', () async {
      await dataSource.logout();
      verify(mockFirebaseAuth.signOut());
    });
  });

  group('changePassword', () {
    final passwordTest = 'password';
    test('should call FirebaseAuthInstance updatePassword', () async {
      when(mockFirebaseAuth.currentUser())
          .thenAnswer((_) async => mockFirebaseUser);

      await dataSource.changePassword(password: passwordTest);

      verify(mockFirebaseAuth.currentUser());
      verify(mockFirebaseUser.updatePassword(passwordTest));
    });

    test('should throw UserDisabledException', () async {
      when(mockFirebaseAuth.currentUser()).thenThrow(UserDisabledException());

      expect(
        () => dataSource.changePassword(password: passwordTest),
        throwsA(isA<UserDisabledException>()),
      );
      verify(mockFirebaseAuth.currentUser());
    });

    test('should throw WeakPasswordException', () async {
      when(mockFirebaseAuth.currentUser()).thenThrow(WeakPasswordException());

      expect(
        () => dataSource.changePassword(password: passwordTest),
        throwsA(isA<WeakPasswordException>()),
      );
      verify(mockFirebaseAuth.currentUser());
    });

    test('should throw UndefinedFirebaseAuthException', () async {
      when(mockFirebaseAuth.currentUser())
          .thenThrow(UndefinedFirebaseAuthException());

      expect(
        () => dataSource.changePassword(password: passwordTest),
        throwsA(isA<UndefinedFirebaseAuthException>()),
      );
      verify(mockFirebaseAuth.currentUser());
    });
  });

  group('resetPassword', () {
    final emailTest = 'john@doe.com';
    test('should call FirebaseAuthInstance sendPasswordResetEmail', () async {
      await dataSource.resetPassword(email: emailTest);
      verify(mockFirebaseAuth.sendPasswordResetEmail(email: emailTest));
    });

    test('should throw UserNotFoundException', () async {
      when(mockFirebaseAuth.sendPasswordResetEmail(
        email: anyNamed('email'),
      )).thenThrow(UserNotFoundException());

      expect(
        () => dataSource.resetPassword(email: emailTest),
        throwsA(isA<UserNotFoundException>()),
      );
      verify(mockFirebaseAuth.sendPasswordResetEmail(email: emailTest));
    });

    test('should throw UndefinedFirebaseAuthException', () async {
      when(mockFirebaseAuth.sendPasswordResetEmail(
        email: anyNamed('email'),
      )).thenThrow(UndefinedFirebaseAuthException());

      expect(
        () => dataSource.resetPassword(email: emailTest),
        throwsA(isA<UndefinedFirebaseAuthException>()),
      );
      verify(mockFirebaseAuth.sendPasswordResetEmail(email: emailTest));
    });
  });
}
