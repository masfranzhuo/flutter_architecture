import 'package:flutter_architecture/core/error/failures/failure.dart';

/// status code 400
class BadRequestFailure extends Failure {
  BadRequestFailure({String message = '', String code})
      : super(message: message, code: code);
}

/// status code 401
class UnauthorizedFailure extends Failure {
  UnauthorizedFailure({String message ='', String code})
      : super(message: message, code: code);
}

/// status code 404
class NotFoundFailure extends Failure {
  NotFoundFailure({String message = '', String code})
      : super(message: message, code: code);
}

/// status code 412
class PreconditionFailedFailure extends Failure {
  PreconditionFailedFailure({String message = '', String code})
      : super(message: message, code: code);
}

/// status code 500
class InternalServerErrorFailure extends Failure {
  InternalServerErrorFailure({String message = '', String code})
      : super(message: message, code: code);
}

/// status code 503
class ServiceUnavailableFailure extends Failure {
  ServiceUnavailableFailure({String message = '', String code})
      : super(message: message, code: code);
}