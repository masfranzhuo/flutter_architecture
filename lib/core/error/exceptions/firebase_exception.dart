import 'package:flutter_architecture/core/error/exceptions/app_exception.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/error/failures/firebase_failure.dart';

class InvalidEmailException extends AppException {
  InvalidEmailException({String message, String code})
      : super(message: message, code: code);

  @override
  Failure toFailure() => InvalidEmailFailure(message: message, code: code);
}

class WrongPasswordException extends AppException {
  WrongPasswordException({String message, String code})
      : super(message: message, code: code);

  @override
  Failure toFailure() => WrongPasswordFailure(message: message, code: code);
}

class UserNotFoundException extends AppException {
  UserNotFoundException({String message, String code})
      : super(message: message, code: code);

  @override
  Failure toFailure() => UserNotFoundFailure(message: message, code: code);
}

class UserDisabledException extends AppException {
  UserDisabledException({String message, String code})
      : super(message: message, code: code);

  @override
  Failure toFailure() => UserDisabledFailure(message: message, code: code);
}

class TooManyRequestsException extends AppException {
  TooManyRequestsException({String message, String code})
      : super(message: message, code: code);

  @override
  Failure toFailure() => TooManyRequestsFailure(message: message, code: code);
}

class OperationNotAllowedException extends AppException {
  OperationNotAllowedException({String message, String code})
      : super(message: message, code: code);

  @override
  Failure toFailure() =>
      OperationNotAllowedFailure(message: message, code: code);
}

class UndefinedFirebaseAuthException extends AppException {
  UndefinedFirebaseAuthException({String message, String code})
      : super(message: message, code: code);

  @override
  Failure toFailure() =>
      UndefinedFirebaseAuthFailure(message: message, code: code);
}

class WeakPasswordException extends AppException {
  WeakPasswordException({String message, String code})
      : super(message: message, code: code);

  @override
  Failure toFailure() => WeakPasswordFailure(message: message, code: code);
}

class EmailAlreadyInUseException extends AppException {
  EmailAlreadyInUseException({String message, String code})
      : super(message: message, code: code);

  @override
  Failure toFailure() => EmailAlreadyInUseFailure(message: message, code: code);
}

class InvalidCredentialException extends AppException {
  InvalidCredentialException({String message, String code})
      : super(message: message, code: code);

  @override
  Failure toFailure() => InvalidCredentialFailure(message: message, code: code);
}

class AccountExistsWithDifferentCredentialException extends AppException {
  AccountExistsWithDifferentCredentialException({String message, String code})
      : super(message: message, code: code);

  @override
  Failure toFailure() => AccountExistsWithDifferentCredentialFailure(message: message, code: code);
}

class InvalidActionCodeException extends AppException {
  InvalidActionCodeException({String message, String code})
      : super(message: message, code: code);

  @override
  Failure toFailure() => InvalidActionCodeFailure(message: message, code: code);
}
