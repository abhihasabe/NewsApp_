import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation/bloc/regbloc/reg_event.dart';
import 'package:form_validation/bloc/regbloc/reg_state.dart';
import 'package:form_validation/repositories/user_repository.dart';
import 'package:form_validation/validations/confirm_password_validation.dart';
import 'package:form_validation/validations/email_validation.dart';
import 'package:form_validation/validations/name_validation.dart';
import 'package:form_validation/validations/password_validation.dart';
import 'package:formz/formz.dart';

class RegBloc extends Bloc<RegEvent, RegState> {
  UserRepository _userRepository;

  RegBloc({UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(const RegState());


  @override
  void onTransition(Transition<RegEvent, RegState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<RegState> mapEventToState(RegEvent regEvent) async* {
    if (regEvent is NameChanged) {
      final name = Name.dirty(regEvent.name);
      yield state.copyWith(
          name: name, status: Formz.validate([name, state.name]));
    } else if (regEvent is EmailChanged) {
      final email = Email.dirty(regEvent.email);
      yield state.copyWith(
          email: email, status: Formz.validate([email, state.email]));
    } else if (regEvent is PasswordChanged) {
      final password = Password.dirty(regEvent.password);
      yield state.copyWith(
          password: password,
          status: Formz.validate([password, state.password]));
    } else if (regEvent is ConfirmPasswordChanged) {
      final confirmPassword = ConfirmPassword.dirty(
          password: state.password.value, value: regEvent.confirmPassword);
      yield state.copyWith(
          confirmPassword: confirmPassword,
          status: Formz.validate(
              [state.name, state.email, state.password, confirmPassword]));
    } else if (regEvent is FormSubmitted) {
      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);
        try {
          await _userRepository.createUserWithEmailAndPassword(
              regEvent.email, regEvent.password);
        } catch (_) {}
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      }
    }
  }
}
