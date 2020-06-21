import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:meta/meta.dart';

abstract class AppException extends Equatable implements Exception {
  final String message;
  final String code;

  const AppException({
    @required this.message,
    @required this.code,
  });

  Failure toFailure();

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [message, code];
}

class UnexpectedException extends AppException {
  const UnexpectedException({String message})
      : super(message: message, code: 'UNEXPECTED_ERROR');

  @override
  Failure toFailure() => UnexpectedFailure(message: message, code: code);
}

class NetworkException extends AppException {
  const NetworkException({String message})
      : super(message: message, code: 'NETWORK_ERROR');

  @override
  Failure toFailure() => NetworkFailure(message: message, code: code);
}

class InvalidIdTokenException extends AppException {
  const InvalidIdTokenException({String message})
      : super(message: message, code: 'INVALID_ID_TOKEN_ERROR');

  @override
  Failure toFailure() => InvalidIdTokenFailure(message: message, code: code);
}