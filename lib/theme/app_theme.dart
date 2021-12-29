import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes {
  static ThemeData baseLight = ThemeData.light();
  static ThemeData baseDark = ThemeData.dark();
  static const double FontTitle = 16.0;

  static final theme = ThemeData(
    primarySwatch: Colors.red,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    indicatorColor: indicatorColor,
    hintColor: hintColor,
    focusColor: focusColor,
    disabledColor: disabledColor,
    cardColor: cardColor,
    errorColor: errorColor,
    iconTheme: IconThemeData(color: iconColor, opacity: 0.8),
    primaryIconTheme:
        ThemeData.light().primaryIconTheme.copyWith(color: accentColor),
    textTheme: _customTextTheme(baseLight.textTheme, textColor, "lightTheme"),
    primaryTextTheme:
        _customTextTheme(baseLight.primaryTextTheme, textColor, "lightTheme"),
    buttonTheme: ThemeData.light().buttonTheme.copyWith(
        buttonColor: Colors.black,
        colorScheme:
            ThemeData.light().colorScheme.copyWith(secondary: Colors.black)),
    colorScheme: ColorScheme.light(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: iconColor.withOpacity(0.7),
      unselectedItemColor: iconColor.withOpacity(0.32),
      selectedIconTheme: IconThemeData(color: primaryColor),
      showUnselectedLabels: true,
    ),
  );

  static TextTheme _customTextTheme(TextTheme base, Color color, String theme) {
    return base
        .copyWith(
          headline6: base.headline6?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
              letterSpacing: 0.15,
              color: theme.contains("darkTheme") ? textColor : textColor),
          headline5: base.headline5?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 24.0,
              letterSpacing: 0.0,
              color: theme.contains("darkTheme") ? textColor : textColor),
          headline4: base.headline4?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 34.0,
              letterSpacing: 0.25,
              color: theme.contains("darkTheme") ? textColor : textColor),
          headline3: base.headline3?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 48.0,
              letterSpacing: 0.0,
              color: theme.contains("darkTheme") ? textColor : textColor),
          headline2: base.headline2?.copyWith(
              fontWeight: FontWeight.w300,
              fontSize: 60.0,
              letterSpacing: -0.5,
              color: theme.contains("darkTheme") ? textColor : textColor),
          headline1: base.headline1?.copyWith(
              fontWeight: FontWeight.w300,
              fontSize: 96.0,
              letterSpacing: -1.5,
              color: theme.contains("darkTheme") ? textColor : textColor),
          subtitle2: base.subtitle2?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              letterSpacing: 0.10,
              color: theme.contains("darkTheme") ? textColor : textColor),
          subtitle1: base.subtitle1?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
              letterSpacing: 0.15,
              color: theme.contains("darkTheme") ? textColor : textColor),
          bodyText2: base.bodyText2?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
              letterSpacing: 0.25,
              color: theme.contains("darkTheme") ? textColor : textColor),
          bodyText1: base.bodyText1?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
              letterSpacing: 0.5,
              color: theme.contains("darkTheme") ? textColor : textColor),
          button: base.button?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
              letterSpacing: 0.75,
              color: theme.contains("darkTheme") ? textColor : textColor),
          caption: base.caption?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
              letterSpacing: 0.4,
              color: theme.contains("darkTheme") ? textColor : textColor),
          overline: base.overline?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 10.0,
              letterSpacing: 1.5,
              color: theme.contains("darkTheme") ? textColor : textColor),
        )
        .apply(fontFamily: 'Roboto');
  }
}
