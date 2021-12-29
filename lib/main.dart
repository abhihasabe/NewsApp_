import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation/bloc/authbloc/authentication_bloc.dart';
import 'package:form_validation/bloc/authbloc/authentication_event.dart';
import 'package:form_validation/bloc/authbloc/authentication_state.dart';
import 'package:form_validation/bloc/homebloc/home_bloc.dart';
import 'package:form_validation/bloc/loginbloc/login_bloc.dart';
import 'package:form_validation/repositories/news_repository.dart';
import 'package:form_validation/repositories/user_repository.dart';
import 'package:form_validation/screens/home_screen.dart';
import 'package:form_validation/screens/login_screen.dart';
import 'package:form_validation/screens/splash_Screen.dart';
import 'package:form_validation/theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  final UserRepository _userRepository = UserRepository();
  final NewsArticleRepository _newsArticlesRepository = NewsArticleRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemes.theme,
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthenticationBloc(userRepository: _userRepository)
                  ..add(AuthenticationEventStarted()),
          ),
          BlocProvider(
            create: (context) => LoginBloc(userRepository: _userRepository),
          ),
          BlocProvider(
            create: (context) =>
                ArticleBloc(repository: _newsArticlesRepository),
          ),
        ],
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, authenticationState) {
            if (authenticationState is AuthenticationStateSuccess) {
              return const HomeScreen();
            } else if (authenticationState is AuthenticationStateFailure) {
              return LoginScreen(userRepository: _userRepository); //LoginPage,
            } else if (authenticationState is AuthenticationStateInitial) {
              return const SplashScreen();
            }
            return const SplashScreen();
          },
        ),
      ),
    );
  }
}
