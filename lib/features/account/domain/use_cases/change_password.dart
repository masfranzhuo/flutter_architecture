import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failure.dart';
import 'package:flutter_architecture/core/util/use_case.dart';
import 'package:flutter_architecture/features/account/domain/repositories/account_repository.dart';
import 'package:meta/meta.dart';

class ChangePassword extends UseCase<bool, Params> {
  final AccountRepository repository;

  ChangePassword({@required this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.changePassword(
      password: params.password,
      currentPassword: params.currentPassword,
    );
  }
}

class Params extends Equatable {
  final String password, currentPassword;

  Params({
    @required this.password,
    @required this.currentPassword,
  });

  @override
  List<Object> get props => [password, currentPassword];
}
