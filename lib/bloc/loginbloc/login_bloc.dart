//import file now
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:form_validation/bloc/loginbloc/login_event.dart';
import 'package:form_validation/bloc/loginbloc/login_state.dart';
import 'package:form_validation/repositories/user_repository.dart';
import 'package:form_validation/validations/email_validation.dart';
import 'package:form_validation/validations/password_validation.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;

  LoginBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(const LoginState());

  @override
  void onTransition(Transition<LoginEvent, LoginState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent loginEvent) async* {
    if (loginEvent is EmailChanged) {
      final email = Email.dirty(loginEvent.email);
      yield state.copyWith(
          email: email, status: Formz.validate([email, state.email]));
    } else if (loginEvent is PasswordChanged) {
      final password = Password.dirty(loginEvent.password);
      yield state.copyWith(
          password: password,
          status: Formz.validate([password, state.password]));
    } else if (loginEvent is FormSubmitted) {
      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);
        try {
          await _userRepository.signInWithEmailAndPassword(
              loginEvent.email, loginEvent.password);
        } catch (_) {}
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      }
    }
  }
}
