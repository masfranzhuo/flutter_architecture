import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/util/use_case.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/repositories/account_repository.dart';
import 'package:meta/meta.dart';

class RegisterWithPassword extends UseCase<Account, Params> {
  final AccountRepository repository;

  RegisterWithPassword({@required this.repository});

  @override
  Future<Either<Failure, Account>> call(Params params) async {
    return await repository.registerWithPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class Params extends Equatable {
  final name, email, password;

  Params({
    @required this.name,
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [name, email, password];
}
