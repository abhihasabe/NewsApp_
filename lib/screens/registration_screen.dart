import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation/bloc/homebloc/home_bloc.dart';
import 'package:form_validation/bloc/loginbloc/login_bloc.dart';
import 'package:form_validation/bloc/regbloc/reg_bloc.dart';
import 'package:form_validation/bloc/regbloc/reg_event.dart';
import 'package:form_validation/bloc/regbloc/reg_state.dart';
import 'package:form_validation/helper/internet_helper.dart';
import 'package:form_validation/repositories/news_repository.dart';
import 'package:form_validation/repositories/user_repository.dart';
import 'package:form_validation/screens/home_screen.dart';
import 'package:form_validation/screens/login_screen.dart';
import 'package:form_validation/theme/app_colors.dart';
import 'package:form_validation/helper/dialog_helper.dart';
import 'package:form_validation/widgets/button_widget.dart';
import 'package:form_validation/widgets/input_field_widget.dart';
import 'package:form_validation/widgets/text_widget.dart';
import 'package:formz/formz.dart';

class RegScreen extends StatefulWidget {
  final UserRepository _userRepository;

  const RegScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  UserRepository get _userRepository => widget._userRepository;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final NewsArticleRepository _newsArticleRepository = NewsArticleRepository();
  RegBloc _registerBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _registerBloc = BlocProvider.of<RegBloc>(context);
  }

  bool get isPopulated =>
      _nameController.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegBloc, RegState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          DialogHelper.dismissProgressBar(context);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Registration Successfully"),
            ));
          });
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => BlocProvider<ArticleBloc>(
                    create: (context) =>
                        ArticleBloc(repository: _newsArticleRepository),
                    child: const HomeScreen()),
              ),
              (route) => false,
            );
          });
        }
        if (state.status.isSubmissionInProgress) {
          print('Logging in progress...');
          WidgetsBinding.instance.addPostFrameCallback((_) {
            DialogHelper.showLoaderDialog(context);
          });
        }
      },
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(12.0),
        child:
            BlocBuilder<RegBloc, RegState>(builder: (context, registerState) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildTitleWidget(),
                    const SizedBox(height: 40),
                    TextFormFieldWidget(
                      controller: _nameController,
                      hintText: "Name",
                      textCapitalization: TextCapitalization.words,
                      textInputType: TextInputType.emailAddress,
                      actionKeyboard: TextInputAction.next,
                      prefixIcon: Icon(
                        Icons.person,
                        color: hoverColorDarkColor,
                      ),
                      errorText: registerState.name.invalid
                          ? 'minimum 5 characters are required !'
                          : null,
                      onChanged: (String value) {
                        context.bloc<RegBloc>().add(NameChanged(name: value));
                      },
                      parametersValidate: "Please enter Name.",
                    ),
                    const SizedBox(height: 10),
                    TextFormFieldWidget(
                      controller: _emailController,
                      hintText: "Email",
                      textCapitalization: TextCapitalization.sentences,
                      textInputType: TextInputType.emailAddress,
                      actionKeyboard: TextInputAction.next,
                      prefixIcon: Icon(
                        Icons.mail,
                        color: hoverColorDarkColor,
                      ),
                      errorText: registerState.email.invalid
                          ? 'please enter valid  email address'
                          : null,
                      onChanged: (String value) {
                        context.bloc<RegBloc>().add(EmailChanged(email: value));
                      },
                      parametersValidate: "Please enter Email.",
                    ),
                    const SizedBox(height: 10),
                    TextFormFieldWidget(
                      controller: _passwordController,
                      hintText: "Password",
                      textCapitalization: TextCapitalization.sentences,
                      textInputType: TextInputType.text,
                      actionKeyboard: TextInputAction.next,
                      obscureText: true,
                      maxLine: 1,
                      prefixIcon: Icon(Icons.lock, color: hoverColorDarkColor),
                      errorText: registerState.password.invalid
                          ? 'minimum 5 character are required !'
                          : null,
                      onChanged: (String value) {
                        context
                            .bloc<RegBloc>()
                            .add(PasswordChanged(password: value));
                      },
                      parametersValidate: "Please enter Password.",
                    ),
                    const SizedBox(height: 10),
                    TextFormFieldWidget(
                      controller: _confirmPasswordController,
                      hintText: "Confirm Password",
                      textCapitalization: TextCapitalization.sentences,
                      textInputType: TextInputType.text,
                      actionKeyboard: TextInputAction.done,
                      obscureText: false,
                      maxLine: 1,
                      prefixIcon: Icon(Icons.lock, color: hoverColorDarkColor),
                      errorText: registerState.confirmPassword.invalid
                          ? 'confirm password does not match'
                          : null,
                      onChanged: (String value) {
                        context.bloc<RegBloc>().add(
                            ConfirmPasswordChanged(confirmPassword: value));
                      },
                      parametersValidate: "Please enter Confirm Password.",
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      textColor: Colors.white,
                      minWidth: double.infinity,
                      text: "SIGN OUT",
                      height: 50.0,
                      borderRadius: 5,
                      color: primaryColor,
                      splashColor: Colors.blue[200],
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 1.2,
                      ),
                      onClick: isPopulated && registerState.status.isValidated
                          ? () => _onRegister()
                          : null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildSignUpText()
                  ]),
            ),
          );
        }),
      )),
    );
  }

  _buildSignUpText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(
          text: "Already have an account?",
          small: true,
          color: buttonColor,
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return BlocProvider<LoginBloc>(
                    create: (context) =>
                        LoginBloc(userRepository: _userRepository),
                    child: LoginScreen(userRepository: _userRepository));
              }),
            );
          },
          child: TextWidget(
            text: "SIGN IN",
            medium: true,
            bold: true,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  _buildTitleWidget() {
    return TextWidget(
      text: "SIGN UP",
      title: true,
      bold: true,
      color: buttonColor,
    );
  }

  void _onRegister() {
    InternetCheck().check().then((internet) {
      if (internet != null && internet) {
        _registerBloc.add(
          FormSubmitted(
              name: _nameController.text,
              email: _emailController.text,
              password: _passwordController.text,
              confirmPassword: _confirmPasswordController.text),
        );
      } else {
        DialogHelper.displayToast("Please check Internet Connection");
      }
    });
  }
}
