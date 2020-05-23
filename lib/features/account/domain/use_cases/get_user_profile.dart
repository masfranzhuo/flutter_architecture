import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/util/use_case.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/repositories/account_repository.dart';
import 'package:meta/meta.dart';

class GetUserProfile extends UseCase<Account, Params> {
  final AccountRepository repository;

  GetUserProfile({@required this.repository});

  @override
  Future<Either<Failure, Account>> call(Params params) async {
    return await repository.getUserProfile(id: params.id);
  }
}

class Params extends Equatable {
  final String id;

  Params({@required this.id});

  @override
  List<Object> get props => [id];
}
