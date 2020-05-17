import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  const UseCase();

  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
