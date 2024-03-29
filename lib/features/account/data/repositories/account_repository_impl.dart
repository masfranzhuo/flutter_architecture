import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_architecture/core/error/exceptions/app_exception.dart';
import 'package:flutter_architecture/core/error/exceptions/http_exception.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/error/failures/http_failure.dart';
import 'package:flutter_architecture/features/account/data/data_sources/account_data_source.dart';
import 'package:flutter_architecture/features/account/data/data_sources/firebase_auth_data_source.dart';
import 'package:flutter_architecture/features/account/data/data_sources/firebase_messaging_data_source.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/repositories/account_repository.dart';
import 'package:meta/meta.dart';

class AccountRepositoryImpl extends AccountRepository {
  final FirebaseAuthDataSource firebaseAuthDataSource;
  final AccountDataSource accountDataSource;
  final FirebaseMessagingDataSource firebaseMessagingDataSource;

  AccountRepositoryImpl({
    @required this.firebaseAuthDataSource,
    @required this.accountDataSource,
    @required this.firebaseMessagingDataSource,
  });

  @override
  Future<Either<Failure, Account>> loginWithPassword({
    @required String email,
    @required String password,
  }) async {
    try {
      final firebaseUser = await firebaseAuthDataSource.signInWithPassword(
          email: email, password: password);

      final deviceToken = await firebaseMessagingDataSource.getDeviceToken();

      await accountDataSource.setUserProfile(
        deviceToken: deviceToken,
        id: firebaseUser.uid,
      );

      final account = await accountDataSource.getUserProfile(
        id: firebaseUser.uid,
      );

      return Right(account);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } on Exception catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Account>> autoLogin() async {
    try {
      final firebaseUser = await firebaseAuthDataSource.getCurrentUser();
      if (firebaseUser == null) {
        return Left(UnauthorizedFailure());
      }

      final deviceToken = await firebaseMessagingDataSource.getDeviceToken();
      if (deviceToken == null) {
        return Left(UnauthorizedFailure());
      }

      final account = await accountDataSource.getUserProfile(
        id: firebaseUser.uid,
      );

      return Right(account);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } on Exception catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Account>> registerWithPassword({
    @required String name,
    @required String email,
    @required String password,
    String photoUrl,
  }) async {
    try {
      final firebaseUser = await firebaseAuthDataSource.signUpWithPassword(
          email: email, password: password);

      final userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = name;

      if (photoUrl != null && photoUrl.isNotEmpty) {
        userUpdateInfo.photoUrl = photoUrl;
      }

      await firebaseAuthDataSource.updateProfile(updateInfo: userUpdateInfo);

      final deviceToken = await firebaseMessagingDataSource.getDeviceToken();

      await accountDataSource.setUserProfile(
        deviceToken: deviceToken,
        id: firebaseUser.uid,
        name: name,
        email: email,
        photoUrl: photoUrl,
      );

      final account = await accountDataSource.getUserProfile(
        id: firebaseUser.uid,
      );

      return Right(account);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } on Exception catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final firebaseUser = await firebaseAuthDataSource.getCurrentUser();
      final deviceToken = await firebaseMessagingDataSource.getDeviceToken();
      final logoutResult = await accountDataSource.removeDeviceToken(
        id: firebaseUser.uid,
        deviceToken: deviceToken,
      );
      await firebaseAuthDataSource.logout();
      return Right(logoutResult);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } on Exception catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getBearerToken() async {
    try {
      final token = await firebaseAuthDataSource.getCurrentUserIdToken();
      return Right(token);
    } on UnauthorizedException {
      return Left(UnauthorizedFailure());
    }
  }

  @override
  Future<Either<Failure, Account>> getUserProfile({@required String id}) async {
    try {
      final account = await accountDataSource.getUserProfile(id: id);
      return Right(account);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } on Exception catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Account>> updateUserProfile({
    @required Account account,
  }) async {
    try {
      final userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = account.name;

      if (account?.photoUrl != null) {
        userUpdateInfo.photoUrl = account.photoUrl;
      }

      await firebaseAuthDataSource.updateProfile(updateInfo: userUpdateInfo);

      final resultAccount = await accountDataSource.updateUserProfile(
        account: account,
      );

      return Right(resultAccount);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } on Exception catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> changePassword({
    @required String password,
    @required String currentPassword,
  }) async {
    try {
      await firebaseAuthDataSource.checkCurrentPassword(
        currentPassword: currentPassword,
      );

      await firebaseAuthDataSource.changePassword(password: password);
      return Right(true);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } on Exception catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> resetPassword({@required String email}) async {
    try {
      await firebaseAuthDataSource.resetPassword(email: email);
      return Right(true);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } on Exception catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
