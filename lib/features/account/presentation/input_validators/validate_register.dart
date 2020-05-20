import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/error/failures/form_failure.dart';
import 'package:flutter_architecture/core/presentation/input_validators/validate_email.dart'
    as ve;
import 'package:flutter_architecture/core/presentation/input_validators/validate_password.dart'
    as vp;
import 'package:flutter_architecture/core/util/input_validator.dart';
import 'package:meta/meta.dart';

class ValidateRegister extends InputValidator<Params> {
  final ve.ValidateEmail validateEmail;
  final vp.ValidatePassword validatePassword;

  ValidateRegister({
    @required this.validateEmail,
    @required this.validatePassword,
  });

  @override
  Either<Failure, bool> call(Params params) {
    if (params.name.length < 3) {
      return Left(NameLessThanCharactersFailure());
    }

    final validateEmailResult = validateEmail(ve.Params(email: params.email));
    if (validateEmailResult.isLeft()) return validateEmailResult;

    final validatePasswordResult = validatePassword(
      vp.Params(password: params.password),
    );
    if (validatePasswordResult.isLeft()) return validatePasswordResult;

    if (params.password != params.retypedPassword) {
      return Left(PasswordAndRetypedMismatchFailure());
    }

    return Right(true);
  }
}

class Params extends Equatable {
  final String name, email, password, retypedPassword;

  Params({
    this.name,
    this.email,
    this.password,
    this.retypedPassword,
  });

  @override
  List<Object> get props => [name, email, password, retypedPassword];
}
