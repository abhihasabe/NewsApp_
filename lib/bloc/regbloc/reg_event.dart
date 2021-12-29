import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RegEvent extends Equatable {
  const RegEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

//event for Name
class NameChanged extends RegEvent {
  final String name;

  const NameChanged({@required this.name});

  @override
  List<Object> get props => [name];
}

//event for email
class EmailChanged extends RegEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];
}

//event for password

class PasswordChanged extends RegEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];
}

//event for Confirm password

class ConfirmPasswordChanged extends RegEvent {
  final String confirmPassword;

  const ConfirmPasswordChanged({@required this.confirmPassword});

  @override
  List<Object> get props => [confirmPassword];
}

//event for submit button
class FormSubmitted extends RegEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  const FormSubmitted(
      {this.name, this.email, @required this.password, this.confirmPassword});

  @override
  // TODO: implement props
  List<Object> get props => [name, email, password, confirmPassword];

  @override
  String toString() =>
      'RegEventPressed, name =$name, email = $email, password = $password, confirmPassword = $confirmPassword';
}
