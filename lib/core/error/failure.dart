import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class Failure extends Equatable {
  final String code, message;

  Failure({@required this.code, @required this.message});

  @override
  List<Object> get props => [code, message];
}

/// Start of Exception Failures

class UnexpectedFailure extends Failure {
  UnexpectedFailure({String message = ''})
      : super(code: 'UNEXPECTED_ERROR', message: message);
}

class NotFoundFailure extends Failure {
  NotFoundFailure({String message = ''})
      : super(code: 'NOT_FOUND_FAILURE', message: message);
}

class UnauthenticatedFailure extends Failure {
  UnauthenticatedFailure({String message = ''})
      : super(code: 'UNAUTHENTICATED_ERROR', message: message);
}

/// End of Exception Failures

/// Start of Non-exception Failures

class BadEmailFormatFailure extends Failure {
  BadEmailFormatFailure({String message = ''})
      : super(code: 'BAD_EMAIL_FORMAT_ERROR', message: message);
}

class PasswordLessThanCharactersFailure extends Failure {
  PasswordLessThanCharactersFailure({String message = ''})
      : super(code: 'PASSWORD_LESS_THAN_CHARACTERS_ERROR', message: message);
}

/// End of Non-exception Failures
