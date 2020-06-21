import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/exceptions/app_exception.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/users_overview/data/data_sources/users_overview_firebase_database_data_source.dart';
import 'package:flutter_architecture/features/users_overview/domain/repositories/users_overview_repository.dart';
import 'package:meta/meta.dart';

class UsersOverviewRepositoryImpl extends UsersOverviewRepository {
  final UsersOverviewFirebaseDatabaseDataSource firebaseDatabaseDataSource;

  UsersOverviewRepositoryImpl({@required this.firebaseDatabaseDataSource});

  @override
  Future<Either<Failure, List<Account>>> getUsers({
    int pageSize,
    String nodeId,
  }) async {
    try {
      final result = await firebaseDatabaseDataSource.getUsers(
        pageSize: pageSize,
        nodeId: nodeId,
      );
      return Right(result);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } on Exception catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getUsersData() async {
    try {
      final result = await firebaseDatabaseDataSource.getUsersData();
      return Right(result);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } on Exception catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
