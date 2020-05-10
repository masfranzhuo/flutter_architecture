import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failure.dart';
import 'package:flutter_architecture/core/util/use_case.dart';
import 'package:flutter_architecture/features/account/domain/repositories/account_repository.dart';
import 'package:meta/meta.dart';

class ResetPassword extends UseCase<bool, Params> {
  final AccountRepository repository;

  ResetPassword({@required this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.resetPassword(email: params.email);
  }
}

class Params extends Equatable {
  final String email;

  Params({@required this.email});

  @override
  List<Object> get props => [email];
}
