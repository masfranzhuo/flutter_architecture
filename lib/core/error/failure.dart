import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class Failure extends Equatable {
  final String code, message;

  Failure({@required this.code, @required this.message});

  @override
  List<Object> get props => [code, message];
}

// Start of Exception Failures

class UnexpectedFailure extends Failure {
  UnexpectedFailure({String message = ''})
      : super(code: 'UNEXPECTED_ERROR', message: message);
}

class NotFoundFailure extends Failure {
  NotFoundFailure({String message = ''})
      : super(code: 'NOT_FOUND_ERROR', message: message);
}

class InvalidIdTokenFailure extends Failure {
  InvalidIdTokenFailure({String message = ''})
      : super(code: 'INVALID_ID_TOKEN_ERROR', message: message);
}

class UnauthenticatedFailure extends Failure {
  UnauthenticatedFailure({String message = ''})
      : super(code: 'UNAUTHENTICATED_ERROR', message: message);
}

class BadRequestFailure extends Failure {
  BadRequestFailure({String message = ''})
      : super(code: 'BAD_REQUEST_ERROR', message: message);
}

class InternalServerErrorFailure extends Failure {
  InternalServerErrorFailure({String message = ''})
      : super(code: 'INTERNAL_SERVER_ERROR', message: message);
}

class ServiceUnavailableFailure extends Failure {
  ServiceUnavailableFailure({String message = ''})
      : super(code: 'SERVICE_UNAVAILABLE_ERROR', message: message);
}

class PreconditionFailedFailure extends Failure {
  PreconditionFailedFailure({String message = ''})
      : super(code: 'PRECONDTION_FAILED_ERROR', message: message);
}

class InvalidEmailFailure extends Failure {
  InvalidEmailFailure({String message = ''})
      : super(code: 'INVALID_EMAIL_ERROR', message: message);
}

class WrongPasswordFailure extends Failure {
  WrongPasswordFailure({String message = ''})
      : super(code: 'WRONG_PASSWORD_ERROR', message: message);
}

class UserNotFoundFailure extends Failure {
  UserNotFoundFailure({String message = ''})
      : super(code: 'USER_NOT_FOUND_ERROR', message: message);
}

class UserDisabledFailure extends Failure {
  UserDisabledFailure({String message = ''})
      : super(code: 'USER_DISABLED_ERROR', message: message);
}

class TooManyRequestsFailure extends Failure {
  TooManyRequestsFailure({String message = ''})
      : super(code: 'TOO_MANY_REQUESTS_ERROR', message: message);
}

class OperationNotAllowedFailure extends Failure {
  OperationNotAllowedFailure({String message = ''})
      : super(code: 'OPERATION_NOT_ALLOWED_ERROR', message: message);
}

class UndefinedFirebaseAuthFailure extends Failure {
  UndefinedFirebaseAuthFailure({String message = ''})
      : super(code: 'UNDEFINED_FIREBASE_AUTH_ERROR', message: message);
}

class WeakPasswordFailure extends Failure {
  WeakPasswordFailure({String message = ''})
      : super(code: 'WEAK_PASSWORD_ERROR', message: message);
}

class EmailAlreadyInUseFailure extends Failure {
  EmailAlreadyInUseFailure({String message = ''})
      : super(code: 'EMAIL_ALREADY_IN_USE_ERROR', message: message);
}
// End of Exception Failures

// Start of Non-exception Failures

class BadEmailFormatFailure extends Failure {
  BadEmailFormatFailure({String message = ''})
      : super(code: 'BAD_EMAIL_FORMAT_ERROR', message: message);
}

class PasswordLessThanCharactersFailure extends Failure {
  PasswordLessThanCharactersFailure({String message = ''})
      : super(code: 'PASSWORD_LESS_THAN_CHARACTERS_ERROR', message: message);
}

class PasswordAndRetypedMismatchFailure extends Failure {
  PasswordAndRetypedMismatchFailure({String message = ''})
      : super(code: 'PASSWORD_AND_RETYPED_MISMATCH_ERROR', message: message);
}

class PasswordAndCurrentPasswordMatchFailure extends Failure {
  PasswordAndCurrentPasswordMatchFailure({String message = ''})
      : super(
            code: 'PASSWORD_AND_CURRENT_PASSWORD_MATCH_ERROR',
            message: message);
}

class NameLessThanCharactersFailure extends Failure {
  NameLessThanCharactersFailure({String message = ''})
      : super(code: 'NAME_LESS_THAN_CHARACTERS_ERROR', message: message);
}

// End of Non-exception Failures
