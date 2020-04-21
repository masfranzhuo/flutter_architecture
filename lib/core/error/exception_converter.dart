import 'package:flutter_architecture/core/error/exception.dart';
import 'package:flutter_architecture/core/error/failure.dart';
import 'package:meta/meta.dart';

Failure convertExceptionToFailure({@required Exception exception}) {
  if (exception is NotFoundException) {
    return NotFoundFailure();
  }

  if (exception is InvalidIdTokenException) {
    return InvalidIdTokenFailure();
  }

  if (exception is UnauthenticatedException) {
    return UnauthenticatedFailure();
  }

  if (exception is InvalidEmailException) {
    return InvalidEmailFailure();
  }

  if (exception is WrongPasswordException) {
    return WrongPasswordFailure();
  }

  if (exception is UserNotFoundException) {
    return UserNotFoundFailure();
  }

  if (exception is UserDisabledException) {
    return UserDisabledFailure();
  }

  if (exception is TooManyRequestsException) {
    return TooManyRequestsFailure();
  }

  if (exception is OperationNotAllowedException) {
    return OperationNotAllowedFailure();
  }

  if (exception is UndefinedFirebaseAuthException) {
    return UndefinedFirebaseAuthFailure();
  }

  if (exception is WeakPasswordException) {
    return WeakPasswordFailure();
  }

  if (exception is EmailAlreadyInUseException) {
    return EmailAlreadyInUseFailure();
  }

  return UnexpectedFailure(message: exception.toString());
}
