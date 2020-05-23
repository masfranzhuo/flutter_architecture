
import 'package:flutter_architecture/core/error/exceptions/app_exception.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/error/failures/http_failure.dart';

/// status code 400
class BadRequestException extends AppException {
  BadRequestException({String message})
      : super(message: message, code: 'BAD_REQUEST_ERROR');

  @override
  Failure toFailure() => BadRequestFailure(message: message, code: code);
}

/// status code 401
class UnauthorizedException extends AppException {
  UnauthorizedException({String message})
      : super(message: message, code: 'UNAUTHORIZED_ERROR');

  @override
  Failure toFailure() => UnauthorizedFailure(message: message, code: code);
}

/// status code 404
class NotFoundException extends AppException {
  NotFoundException({String message})
      : super(message: message, code: 'NOT_FOUND_ERROR');

  @override
  Failure toFailure() => NotFoundFailure(message: message, code: code);
}

/// status code 412
class PreconditionFailedException extends AppException {
  PreconditionFailedException({String message})
      : super(message: message, code: 'PRECONDITION_FAILED_ERROR');

  @override
  Failure toFailure() => PreconditionFailedFailure(message: message, code: code);
}

/// status code 500
class InternalServerErrorException extends AppException {
  InternalServerErrorException({String message})
      : super(message: message, code: 'INTERNAL_SERVER_ERROR_ERROR');

  @override
  Failure toFailure() => InternalServerErrorFailure(message: message, code: code);
}

/// status code 503
class ServiceUnavailableException extends AppException {
  ServiceUnavailableException({String message})
      : super(message: message, code: 'SERVICE_UNAVAILABLE_ERROR');

  @override
  Failure toFailure() => ServiceUnavailableFailure(message: message, code: code);
}