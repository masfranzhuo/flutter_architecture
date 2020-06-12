import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/util/use_case.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/repositories/account_repository.dart';
import 'package:meta/meta.dart';

class GetUsers extends UseCase<List<Account>, NoParams> {
  final AccountRepository repository;

  GetUsers({@required this.repository});
  @override
  Future<Either<Failure, List<Account>>> call(NoParams params) async {
    return await repository.getUsers();
  }
}