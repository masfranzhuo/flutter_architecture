import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/util/use_case.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/repositories/account_repository.dart';
import 'package:meta/meta.dart';

class UpdateUserProfile extends UseCase<Account, Params> {
  final AccountRepository repository;

  UpdateUserProfile({@required this.repository});

  @override
  Future<Either<Failure, Account>> call(Params params) async {
    return await repository.updateUserProfile(account: params.account);
  }
}

class Params extends Equatable {
  final Account account;

  Params({@required this.account});

  @override
  List<Object> get props => [id];
}
