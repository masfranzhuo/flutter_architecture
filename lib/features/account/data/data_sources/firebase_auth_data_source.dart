import 'package:firebase_auth/firebase_auth.dart';
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

  /// Get current FirebaseUser.
  /// Firebase will manage this for us to make our life easier.
  ///
  /// Will return null if there's currently no FirebaseUser.
  Future<FirebaseUser> getCurrentFirebaseUser();

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

  Future<void> logout();
}
