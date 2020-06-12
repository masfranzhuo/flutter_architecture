import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/util/use_case.dart';
import 'package:flutter_architecture/features/account/domain/repositories/account_repository.dart';
import 'package:meta/meta.dart';

class GetUsersData extends UseCase<List<Map<String, dynamic>>, NoParams> {
  final AccountRepository repository;

  GetUsersData({@required this.repository});
  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> call(
    NoParams params,
  ) async {
    return await repository.getUsersData();
  }
}
