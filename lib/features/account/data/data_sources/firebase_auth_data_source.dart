import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_architecture/core/error/exceptions/firebase_exception.dart';
import 'package:flutter_architecture/core/error/exceptions/http_exception.dart';
import 'package:meta/meta.dart';

abstract class FirebaseAuthDataSource {
  /// Sign in with user's password and returns its account object.
  /// FirebaseUser's claims.isStaff can be used to determine which
  /// dashboard to show next.
  Future<FirebaseUser> signInWithPassword({
    @required String email,
    @required String password,
  });

  /// This is not working unused function
  Future<FirebaseUser> signInWithCredential({
    @required String deviceToken,
    @required String providerId,
  });

  /// Register a new firebase auth user with email and password.
  Future<FirebaseUser> signUpWithPassword({
    @required String email,
    @required String password,
  });

  /// Update a currentUser's displayName or photoUrl or both
  /// as specified in updateInfo.
  Future<void> updateProfile({
    @required UserUpdateInfo updateInfo,
  });

  /// Get current idToken from current FirebaseUser.
  /// Firebase will manage this for us to make our life easier,
  /// including minting the token if it's expired.
  ///
  /// Ensured to return a valid, non-expired idToken related to this user.
  /// (Don't worry about it)
  ///
  /// Will return null if getCurrentUser is null.
  /// Won't throw any exception
  Future<String> getCurrentUserIdToken();

  Future<FirebaseUser> getCurrentUser();

  Future<void> logout();

  Future<void> checkCurrentPassword({@required String currentPassword});

  Future<void> changePassword({@required String password});

  Future<void> resetPassword({@required String email});
}

class FirebaseAuthDataSourceImpl extends FirebaseAuthDataSource {
  final FirebaseAuth firebaseAuthInstance;

  FirebaseAuthDataSourceImpl({@required this.firebaseAuthInstance});

  @override
  Future<FirebaseUser> signInWithPassword({
    @required String email,
    @required String password,
  }) async {
    try {
      final authResult = await firebaseAuthInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return authResult.user;
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          throw InvalidEmailException(code: e.code, message: e.message);
        case 'ERROR_WRONG_PASSWORD':
          throw WrongPasswordException(code: e.code, message: e.message);
        case 'ERROR_USER_NOT_FOUND':
          throw UserNotFoundException(code: e.code, message: e.message);
        case 'ERROR_USER_DISABLED':
          throw UserDisabledException(code: e.code, message: e.message);
        case 'ERROR_TOO_MANY_REQUESTS':
          throw TooManyRequestsException(code: e.code, message: e.message);
        case 'ERROR_OPERATION_NOT_ALLOWED':
          throw OperationNotAllowedException(code: e.code, message: e.message);
        default:
          throw UndefinedFirebaseAuthException(code: e.code, message: e.message);
      }
    }
  }

  Future<FirebaseUser> signInWithCredential({
    @required String deviceToken,
    @required String providerId,
  }) async {
    try {
      final oAuthProvider = OAuthProvider(
        providerId: providerId,
      );

      final credential = oAuthProvider.getCredential(
        idToken: deviceToken,
      );

      final authResult = await firebaseAuthInstance.signInWithCredential(
        credential,
      );

      return authResult.user;
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'ERROR_INVALID_CREDENTIAL':
          throw InvalidCredentialException(code: e.code, message: e.message);
        case 'ERROR_USER_DISABLED':
          throw UserDisabledException(code: e.code, message: e.message);
        case 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL':
          throw AccountExistsWithDifferentCredentialException(code: e.code, message: e.message);
        case 'ERROR_OPERATION_NOT_ALLOWED':
          throw OperationNotAllowedException(code: e.code, message: e.message);
        case 'ERROR_INVALID_ACTION_CODE':
          throw InvalidActionCodeException(code: e.code, message: e.message);
        default:
          throw UndefinedFirebaseAuthException(code: e.code, message: e.message);
      }
    }
  }

  @override
  Future<FirebaseUser> signUpWithPassword({
    @required String email,
    @required String password,
  }) async {
    try {
      final authResult =
          await firebaseAuthInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return authResult?.user;
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          throw InvalidEmailException(code: e.code, message: e.message);
        case 'ERROR_WEAK_PASSWORD':
          throw WeakPasswordException(code: e.code, message: e.message);
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          throw EmailAlreadyInUseException(code: e.code, message: e.message);
        default:
          throw UndefinedFirebaseAuthException(code: e.code, message: e.message);
      }
    }
  }

  @override
  Future<void> updateProfile({@required UserUpdateInfo updateInfo}) async {
    try {
      final firebaseUser = await firebaseAuthInstance.currentUser();
      await firebaseUser.updateProfile(updateInfo);
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'ERROR_USER_DISABLED':
          throw UserDisabledException(code: e.code, message: e.message);
        case 'ERROR_USER_NOT_FOUND':
          throw UserNotFoundException(code: e.code, message: e.message);
        default:
          throw UndefinedFirebaseAuthException(code: e.code, message: e.message);
      }
    }
  }

  @override
  Future<String> getCurrentUserIdToken() async {
    final currentUser = await firebaseAuthInstance.currentUser();

    if (currentUser == null) throw UnauthorizedException();
    return (await currentUser.getIdToken()).token;
  }

  @override
  Future<FirebaseUser> getCurrentUser() async {
    final currentUser = await firebaseAuthInstance.currentUser();

    if (currentUser == null) throw UnauthorizedException();
    return currentUser;
  }

  @override
  Future<void> logout() async {
    return await firebaseAuthInstance.signOut();
  }

  @override
  Future<void> checkCurrentPassword({@required String currentPassword}) async {
    try {
      final firebaseUser = await firebaseAuthInstance.currentUser();

      final credential = EmailAuthProvider.getCredential(
        email: firebaseUser.email,
        password: currentPassword,
      );

      await firebaseUser.reauthenticateWithCredential(credential);
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'ERROR_INVALID_CREDENTIAL':
          throw InvalidCredentialException(code: e.code, message: e.message);
        case 'ERROR_USER_DISABLED':
          throw UserDisabledException(code: e.code, message: e.message);
        case 'ERROR_USER_NOT_FOUND':
          throw UserNotFoundException(code: e.code, message: e.message);
        case 'ERROR_WRONG_PASSWORD':
          throw WrongPasswordException(code: e.code, message: e.message);
        case 'ERROR_OPERATION_NOT_ALLOWED':
          throw OperationNotAllowedException(code: e.code, message: e.message);
        default:
          throw UndefinedFirebaseAuthException(code: e.code, message: e.message);
      }
    }
  }

  @override
  Future<void> changePassword({@required String password}) async {
    try {
      final firebaseUser = await firebaseAuthInstance.currentUser();
      await firebaseUser.updatePassword(password);
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'ERROR_USER_DISABLED':
          throw UserDisabledException(code: e.code, message: e.message);
        case 'ERROR_WEAK_PASSWORD':
          throw WeakPasswordException(code: e.code, message: e.message);
        default:
          throw UndefinedFirebaseAuthException(code: e.code, message: e.message);
      }
    }
  }

  @override
  Future<void> resetPassword({@required String email}) async {
    try {
      return await firebaseAuthInstance.sendPasswordResetEmail(email: email);
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'ERROR_USER_NOT_FOUND':
          throw UserNotFoundException();
        default:
          throw UndefinedFirebaseAuthException();
      }
    }
  }
}
