import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/util/use_case.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/users_overview/domain/repositories/users_overview_repository.dart';
import 'package:meta/meta.dart';

class GetUsers extends UseCase<List<Account>, Params> {
  final UsersOverviewRepository repository;

  GetUsers({@required this.repository});
  @override
  Future<Either<Failure, List<Account>>> call(Params params) async {
    return await repository.getUsers(
      pageSize: params.pageSize,
      nodeId: params.nodeId,
    );
  }
}

class Params extends Equatable {
  final int pageSize;
  final String nodeId;

  Params({this.pageSize, this.nodeId});

  @override
  List<Object> get props => [pageSize, nodeId];
}
