import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failures/form_failure.dart';
import 'package:flutter_architecture/features/account/presentation/input_validators/validate_update_user_profile.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ValidateUpdateUserProfile validateUpdateUserProfile;

  setUp(() {
    validateUpdateUserProfile = ValidateUpdateUserProfile();
  });

  test('should return NameLessThanCharactersFailure', () {
    final nameTest = 'Jo';
    final phoneNumberTest = '081212345678';

    final result = validateUpdateUserProfile(Params(
      name: nameTest,
      phoneNumber: phoneNumberTest,
    ));

    expect(result, Left(NameLessThanCharactersFailure()));
  });

  test('should return PhoneNumberNotValidFailure', () {
    final nameTest = 'John Doe';
    final phoneNumberTest = '08';

    final result = validateUpdateUserProfile(Params(
      name: nameTest,
      phoneNumber: phoneNumberTest,
    ));

    expect(result, Left(PhoneNumberNotValidFailure()));
  });
 
  test('should return true', () {
    final nameTest = 'John Doe';
    final phoneNumberTest = '081212345678';

    final result = validateUpdateUserProfile(Params(
      name: nameTest,
      phoneNumber: phoneNumberTest,
    ));

    expect(result, Right(true));
  });
}
