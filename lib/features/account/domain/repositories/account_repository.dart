import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:meta/meta.dart';

abstract class AccountRepository {
  /// Login a user with email and password.
  /// * [deviceToken] Needed to send firebase notification from backend
  Future<Either<Failure, Account>> loginWithPassword({
    @required String email,
    @required String password,
  });

  Future<Either<Failure, Account>> autoLogin();

  Future<Either<Failure, Account>> registerWithPassword({
    @required String name,
    @required String email,
    @required String password,
    String photoUrl,
  });

  Future<Either<Failure, bool>> logout();

  Future<Either<Failure, String>> getBearerToken();

  /// Get a user profile based on the specified idToken
  /// in the initialized http client.
  /// Will return Left(NotFoundFailure) if not found
  Future<Either<Failure, Account>> getUserProfile({@required String id});

  Future<Either<Failure, Account>> updateUserProfile({
    @required Account account,
  });

  Future<Either<Failure, bool>> changePassword({
    @required String password,
    @required String currentPassword,
  });

  Future<Either<Failure, bool>> resetPassword({@required String email});

  Future<Either<Failure, List<Account>>> getUsers();

  Future<Either<Failure, List<Map<String, dynamic>>>> getUsersData();
}
