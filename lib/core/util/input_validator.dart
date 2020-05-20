import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';

abstract class InputValidator<T> {
  const InputValidator();
  
  Either<Failure, bool> call(T params);
}
