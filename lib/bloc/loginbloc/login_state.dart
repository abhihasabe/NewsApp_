import 'package:form_validation/validations/email_validation.dart';
import 'package:form_validation/validations/password_validation.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class LoginState extends Equatable {
//declare variables
  final Email email;
  final Password password;
  final FormzStatus status;

  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  //copy email with user enter email
  LoginState copyWith({
    Email email,  //create this email,password classs
    Password password,
    FormzStatus status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, status];

  @override
  bool get stringify => true;
}