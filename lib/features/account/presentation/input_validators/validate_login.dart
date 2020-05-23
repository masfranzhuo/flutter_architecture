import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/presentation/input_validators/validate_email.dart'
    as ve;
import 'package:flutter_architecture/core/presentation/input_validators/validate_password.dart'
    as vp;
import 'package:flutter_architecture/core/util/input_validator.dart';
import 'package:meta/meta.dart';

class ValidateLogin extends InputValidator<Params> {
  final ve.ValidateEmail validateEmail;
  final vp.ValidatePassword validatePassword;

  ValidateLogin({
    @required this.validateEmail,
    @required this.validatePassword,
  });

  @override
  Either<Failure, bool> call(Params params) {
    final validateEmailResult = validateEmail(ve.Params(email: params.email));
    if (validateEmailResult.isLeft()) return validateEmailResult;

    final validatePasswordResult = validatePassword(
      vp.Params(password: params.password),
    );
    if (validatePasswordResult.isLeft()) return validatePasswordResult;

    return Right(true);
  }
}

class Params extends Equatable {
  final String email, password;

  Params({
    this.email,
    this.password,
  });

  @override
  List<Object> get props => [email, password];
}
