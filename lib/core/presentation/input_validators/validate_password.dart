import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/error/failures/form_failure.dart';
import 'package:flutter_architecture/core/util/input_validator.dart';
import 'package:meta/meta.dart';

class ValidatePassword extends InputValidator<Params> {
  @override
  Either<Failure, bool> call(Params params) {
    if (params.password.length < 6) {
      return Left(PasswordLessThanCharactersFailure());
    }
    return Right(true);
  }
}

class Params extends Equatable {
  final String password;

  Params({@required this.password});

  @override
  List<Object> get props => [password];
}
