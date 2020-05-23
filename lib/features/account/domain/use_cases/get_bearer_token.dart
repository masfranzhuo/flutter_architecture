import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/util/use_case.dart';
import 'package:flutter_architecture/features/account/domain/repositories/account_repository.dart';
import 'package:meta/meta.dart';

class GetBearerToken extends UseCase<String, NoParams> {
  final AccountRepository repository;

  GetBearerToken({@required this.repository});

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await repository.getBearerToken();
  }
}
