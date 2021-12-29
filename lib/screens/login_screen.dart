import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation/bloc/homebloc/home_bloc.dart';
import 'package:form_validation/bloc/loginbloc/login_bloc.dart';
import 'package:form_validation/bloc/loginbloc/login_event.dart';
import 'package:form_validation/bloc/loginbloc/login_state.dart';
import 'package:form_validation/bloc/regbloc/reg_bloc.dart';
import 'package:form_validation/helper/internet_helper.dart';
import 'package:form_validation/repositories/news_repository.dart';
import 'package:form_validation/repositories/user_repository.dart';
import 'package:form_validation/screens/home_screen.dart';
import 'package:form_validation/screens/registration_screen.dart';
import 'package:form_validation/theme/app_colors.dart';
import 'package:form_validation/helper/dialog_helper.dart';
import 'package:form_validation/widgets/button_widget.dart';
import 'package:form_validation/widgets/input_field_widget.dart';
import 'package:form_validation/widgets/text_widget.dart';
import 'package:formz/formz.dart';

class LoginScreen extends StatefulWidget {
  final UserRepository _userRepository;

  const LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginBloc _loginBloc;
  String changeEmailValue, chagePasswordValue;

  UserRepository get _userRepository => widget._userRepository;
  final NewsArticleRepository _newsArticleRepository = NewsArticleRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          DialogHelper.dismissProgressBar(context);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Login Successfully"),
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
      child: Scaffold(body:
          BlocBuilder<LoginBloc, LoginState>(builder: (context, loginState) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildTitleWidget(),
                    const SizedBox(height: 40),
                    TextFormFieldWidget(
                      controller: _emailController,
                      hintText: "Email",
                      textCapitalization: TextCapitalization.sentences,
                      textInputType: TextInputType.emailAddress,
                      actionKeyboard: TextInputAction.next,
                      errorText:
                          loginState.email.invalid ? 'Invalid Email' : null,
                      onChanged: (String value) {
                        context
                            .bloc<LoginBloc>()
                            .add(EmailChanged(email: value));
                      },
                      prefixIcon: Icon(
                        Icons.email,
                        color: hoverColorDarkColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormFieldWidget(
                      controller: _passwordController,
                      hintText: "Password",
                      textCapitalization: TextCapitalization.sentences,
                      textInputType: TextInputType.text,
                      actionKeyboard: TextInputAction.done,
                      obscureText: true,
                      showSuffixIcon: true,
                      maxLine: 1,
                      errorText: loginState.password.invalid
                          ? 'minimum 5 character are required !'
                          : null,
                      onChanged: (String value) {
                        context
                            .bloc<LoginBloc>()
                            .add(PasswordChanged(password: value));
                      },
                      suffixIcon:
                          Icon(Icons.visibility, color: hoverColorDarkColor),
                      prefixIcon: Icon(Icons.lock, color: hoverColorDarkColor),
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      textColor: Colors.white,
                      minWidth: double.infinity,
                      text: "SIGN IN",
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
                      onClick: isPopulated && loginState.status.isValidated
                          ? () => _onLoginEmailAndPassword(loginState)
                          : null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildSignUpText()
                  ]),
            ),
          ),
        );
      })),
    );
  }

  _buildSignUpText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(
          text: "Does not have an account?",
          small: true,
          color: buttonColor,
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return BlocProvider<RegBloc>(
                    create: (context) =>
                        RegBloc(userRepository: _userRepository),
                    child: RegScreen(userRepository: _userRepository));
              }),
            );
          },
          child: TextWidget(
            text: "SIGN UP",
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
      text: "LOGIN",
      title: true,
      bold: true,
      color: buttonColor,
    );
  }

  void _onLoginEmailAndPassword(LoginState loginState) {
    InternetCheck().check().then((internetConnection) {
      if (internetConnection != null && internetConnection) {
        _loginBloc.add(FormSubmitted(
            email: _emailController.text, password: _passwordController.text));
      } else {
        DialogHelper.displayToast("Please check Internet Connection");
      }
    });
    //Failed because user does not exist
  }
}
