import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_architecture/core/error/exception.dart';
import 'package:meta/meta.dart';

abstract class FirebaseAuthDataSource {
  /// Sign in with user's password and returns its account object.
  /// FirebaseUser's claims.isStaff can be used to determine which
  /// dashboard to show next.
  Future<FirebaseUser> signInWithPassword({
    @required String email,
    @required String password,
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

  Future<String> getCurrentUserId();

  Future<void> logout();
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
          email: email, password: password);
      return authResult.user;
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          throw InvalidEmailException();
        case 'ERROR_WRONG_PASSWORD':
          throw WrongPasswordException();
        case 'ERROR_USER_NOT_FOUND':
          throw UserNotFoundException();
        case 'ERROR_USER_DISABLED':
          throw UserDisabledException();
        case 'ERROR_TOO_MANY_REQUESTS':
          throw TooManyRequestsException();
        case 'ERROR_OPERATION_NOT_ALLOWED':
          throw OperationNotAllowedException();
        default:
          throw UndefinedFirebaseAuthException();
      }
    }
  }

  @override
  Future<FirebaseUser> signUpWithPassword({
    @required String email,
    @required String password,
  }) async {
    try {
      final authResult = await firebaseAuthInstance
          .createUserWithEmailAndPassword(email: email, password: password);
      return authResult?.user;
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          throw InvalidEmailException();
        case 'ERROR_WEAK_PASSWORD':
          throw WeakPasswordException();
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          throw EmailAlreadyInUseException();
        default:
          throw UndefinedFirebaseAuthException();
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
          throw UserDisabledException();
        case 'ERROR_USER_NOT_FOUND':
          throw UserNotFoundException();
        default:
          throw UndefinedFirebaseAuthException();
      }
    }
  }

  @override
  Future<String> getCurrentUserIdToken() async {
    final currentUser = await firebaseAuthInstance.currentUser();

    if (currentUser == null) throw UnauthenticatedException();
    return (await currentUser.getIdToken()).token;
  }

  @override
  Future<String> getCurrentUserId() async {
    final currentUser = await firebaseAuthInstance.currentUser();

    if (currentUser == null) throw UnauthenticatedException();
    return currentUser.uid;
  }

  @override
  Future<void> logout() async {
    return firebaseAuthInstance.signOut();
  }
}
