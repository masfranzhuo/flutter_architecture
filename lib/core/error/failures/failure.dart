import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class Failure extends Equatable {
  final String message, code;

  Failure({@required this.message, @required this.code});

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [message, code];
}

class UnexpectedFailure extends Failure {
  UnexpectedFailure({String message = '', String code})
      : super(message: message, code: code);
}

class NetworkFailure extends Failure {
  NetworkFailure({String message = '', String code})
      : super(message: message, code: code);
}

class InvalidIdTokenFailure extends Failure {
  InvalidIdTokenFailure({String message = '', String code})
      : super(message: message, code: code);
}
