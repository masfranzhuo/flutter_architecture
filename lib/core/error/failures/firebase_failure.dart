import 'package:flutter_architecture/core/error/failures/failure.dart';

class InvalidEmailFailure extends Failure {
  InvalidEmailFailure({String message = '', String code})
      : super(message: message, code: code);
}

class WrongPasswordFailure extends Failure {
  WrongPasswordFailure({String message = '', String code})
      : super(message: message, code: code);
}

class UserNotFoundFailure extends Failure {
  UserNotFoundFailure({String message = '', String code})
      : super(message: message, code: code);
}

class UserDisabledFailure extends Failure {
  UserDisabledFailure({String message = '', String code})
      : super(message: message, code: code);
}

class TooManyRequestsFailure extends Failure {
  TooManyRequestsFailure({String message = '', String code})
      : super(message: message, code: code);
}

class OperationNotAllowedFailure extends Failure {
  OperationNotAllowedFailure({String message = '', String code})
      : super(message: message, code: code);
}

class UndefinedFirebaseAuthFailure extends Failure {
  UndefinedFirebaseAuthFailure({String message = '', String code})
      : super(message: message, code: code);
}

class WeakPasswordFailure extends Failure {
  WeakPasswordFailure({String message = '', String code})
      : super(message: message, code: code);
}

class EmailAlreadyInUseFailure extends Failure {
  EmailAlreadyInUseFailure({String message = '', String code})
      : super(message: message, code: code);
}
