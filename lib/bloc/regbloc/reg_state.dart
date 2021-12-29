import 'package:form_validation/validations/confirm_password_validation.dart';
import 'package:form_validation/validations/email_validation.dart';
import 'package:form_validation/validations/name_validation.dart';
import 'package:form_validation/validations/password_validation.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class RegState extends Equatable {
//declare variables
  final Name name;
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;
  final FormzStatus status;

  const RegState({
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.status = FormzStatus.pure,
  });

  //copy email with user enter email
  RegState copyWith({
    Name name,
    Email email, //create this email,password classs
    Password password,
    ConfirmPassword confirmPassword,
    FormzStatus status,
  }) {
    return RegState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [name, email, password, confirmPassword, status];

  @override
  bool get stringify => true;
}
