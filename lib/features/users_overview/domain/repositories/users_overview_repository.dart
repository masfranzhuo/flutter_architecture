import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';

abstract class UsersOverviewRepository {
  Future<Either<Failure, List<Account>>> getUsers({
    int pageSize,
    String nodeId,
  });

  Future<Either<Failure, List<Map<String, dynamic>>>> getUsersData();
}
