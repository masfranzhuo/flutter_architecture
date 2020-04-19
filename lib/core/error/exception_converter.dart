import 'package:flutter_architecture/core/error/exception.dart';
import 'package:flutter_architecture/core/error/failure.dart';
import 'package:meta/meta.dart';

Failure convertExceptionToFailure({@required Exception exception}) {
  if (exception is NotFoundException) {
    return NotFoundFailure();
  }

  if (exception is UnauthenticatedException) {
    return UnauthenticatedFailure();
  }

  return UnexpectedFailure(message: exception.toString());
}
