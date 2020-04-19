import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failure.dart';
import 'package:flutter_architecture/core/util/input_validator.dart';
import 'package:meta/meta.dart';

class ValidateEmail extends InputValidator<Params> {
  @override
  Either<Failure, bool> call(Params params) {
    if (params.email.indexOf('@') == -1 || params.email.indexOf('.') == -1) {
      return Left(BadEmailFormatFailure());
    }
    return Right(true);
  }
}

class Params extends Equatable {
  final String email;

  const Params({@required this.email});

  @override
  List<Object> get props => [email];
}
