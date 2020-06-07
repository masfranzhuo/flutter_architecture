import 'package:flutter_architecture/core/error/failures/failure.dart';

class BadEmailFormatFailure extends Failure {
  BadEmailFormatFailure({String message = ''})
      : super(message: message, code: 'BAD_EMAIL_FORMAT_ERROR');
}

class PasswordLessThanCharactersFailure extends Failure {
  PasswordLessThanCharactersFailure({String message = ''})
      : super(message: message, code: 'PASSWORD_LESS_THAN_CHARACTERS_ERROR');
}

class PasswordAndRetypedMismatchFailure extends Failure {
  PasswordAndRetypedMismatchFailure({String message = ''})
      : super(message: message, code: 'PASSWORD_AND_RETYPED_MISMATCH_ERROR');
}

class PasswordAndCurrentPasswordMatchFailure extends Failure {
  PasswordAndCurrentPasswordMatchFailure({String message = ''})
      : super(
            message: message,
            code: 'PASSWORD_AND_CURRENT_PASSWORD_MATCH_ERROR');
}

class NameLessThanCharactersFailure extends Failure {
  NameLessThanCharactersFailure({String message = ''})
      : super(message: message, code: 'NAME_LESS_THAN_CHARACTERS_ERROR');
}

class PhoneNumberNotValidFailure extends Failure {
  PhoneNumberNotValidFailure({String message = ''})
      : super(message: message, code: 'PHONE_NUMBER_NOT_VALID_ERROR');
}