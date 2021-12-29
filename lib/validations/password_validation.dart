//validate password
import 'package:formz/formz.dart';

//return invalid if password does not match with expression
enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');

  const Password.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  //RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  PasswordValidationError validator(String value) {
    return value.isNotEmpty == true &&
            value.length > 5 /*&&
            _passwordRegex.hasMatch(value)*/
        ? null
        : PasswordValidationError.invalid;
  }
}
