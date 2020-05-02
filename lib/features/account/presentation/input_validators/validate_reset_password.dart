import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failure.dart';
import 'package:flutter_architecture/core/presentation/input_validators/validate_email.dart'
    as ve;
import 'package:flutter_architecture/core/util/input_validator.dart';
import 'package:meta/meta.dart';

class ValidateResetPassword extends InputValidator<Params> {
  final ve.ValidateEmail validateEmail;

  ValidateResetPassword({@required this.validateEmail});

  @override
  Either<Failure, bool> call(Params params) {
    final validateEmailResult = validateEmail(ve.Params(email: params.email));
    if (validateEmailResult.isLeft()) return validateEmailResult;

    return Right(true);
  }
}

class Params extends Equatable {
  final String email;

  Params({this.email});

  @override
  List<Object> get props => [email];
}
