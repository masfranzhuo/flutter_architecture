import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/error/failures/form_failure.dart';
import 'package:flutter_architecture/core/presentation/input_validators/validate_password.dart'
    as vp;
import 'package:flutter_architecture/core/util/input_validator.dart';
import 'package:meta/meta.dart';

class ValidateChangePassword extends InputValidator<Params> {
  final vp.ValidatePassword validatePassword;

  ValidateChangePassword({@required this.validatePassword});

  @override
  Either<Failure, bool> call(Params params) {
    if (params.currentPassword == null || params.currentPassword.isEmpty) {
      return Left(FieldEmptyFailure());
    }

    final validatePasswordResult = validatePassword(vp.Params(
      password: params.password,
    ));
    if (validatePasswordResult.isLeft()) return validatePasswordResult;

    if (params.password == params.currentPassword) {
      return Left(PasswordAndCurrentPasswordMatchFailure());
    }

    if (params.password != params.retypedPassword) {
      return Left(PasswordAndRetypedMismatchFailure());
    }

    return Right(true);
  }
}

class Params extends Equatable {
  final String currentPassword, password, retypedPassword;

  Params({
    @required this.currentPassword,
    @required this.password,
    @required this.retypedPassword,
  });

  @override
  List<Object> get props => [currentPassword, password, retypedPassword];
}
