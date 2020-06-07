import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/error/failures/form_failure.dart';
import 'package:flutter_architecture/core/util/input_validator.dart';
import 'package:meta/meta.dart';

class ValidateUpdateUserProfile extends InputValidator<Params> {
  @override
  Either<Failure, bool> call(Params params) {
    if (params.name.length < 3) {
      return Left(NameLessThanCharactersFailure());
    }

    if (params.phoneNumber.length < 4) {
      return Left(PhoneNumberNotValidFailure());
    }
    
    return Right(true);
  }
}

class Params extends Equatable {
  final String name, phoneNumber;

  Params({
    @required this.name,
    @required this.phoneNumber,
  });

  @override
  List<Object> get props => [name, phoneNumber];
}
