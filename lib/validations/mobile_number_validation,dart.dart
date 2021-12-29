import 'package:formz/formz.dart';

//create enum

enum MobileNumberValidationError { invalid }

//create class to validate email address

class MobileNumber extends FormzInput<String, MobileNumberValidationError> {
  const MobileNumber.pure() : super.pure('');

  const MobileNumber.dirty([String value = '']) : super.dirty(value);

  @override
  MobileNumberValidationError validator(String value) {
    return value.isNotEmpty == true &&
        value.length >= 10
        ? null
        : MobileNumberValidationError.invalid;
  }
}
