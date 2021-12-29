import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

//event for email
class EmailChanged extends LoginEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];
}

//event for password

class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];
}

//event for submit button
class FormSubmitted extends LoginEvent {
  final String email;
  final String password;

  const FormSubmitted({@required this.email, @required this.password});

  @override
  // TODO: implement props
  List<Object> get props => [email, password];

  @override
  String toString() =>
      'LoginEventWithEmailAndPasswordPressed, email = $email, password = $password';
}
