import 'package:formz/formz.dart';

//create enum

enum NameValidationError { invalid }

//create class to validate email address

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');

  const Name.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError validator(String value) {
    return value.isNotEmpty == true &&
        value.length > 5
        ? null
        : NameValidationError.invalid;
  }
}
