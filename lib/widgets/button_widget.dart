import 'package:form_validation/theme/app_colors.dart';
import 'package:flutter/material.dart';

ButtonTheme CustomButton(
    {VoidCallback onClick,
    String text,
    Color textColor,
    Color color,
    Color splashColor,
    double borderRadius,
    double minWidth,
    double height,
    Color borderSideColor,
    TextStyle style,
    Widget leadingIcon,
    Widget trailingIcon}) {
  return ButtonTheme(
    minWidth: minWidth,
    height: height,
    child: RaisedButton(
        splashColor: buttonColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 25)),
        textColor: Colors.white,
        color: primaryColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // This is must when you are using Row widget inside Raised Button
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //_buildLeadingIcon(leadingIcon!),
            Text(
              text ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                letterSpacing: 1.2,
              ),
            ),
            //_buildtrailingIcon(trailingIcon!),
          ],
        ),
        onPressed: onClick),
  );
}

Widget _buildLeadingIcon(Widget leadingIcon) {
  if (leadingIcon != null) {
    return Row(
      children: <Widget>[leadingIcon, SizedBox(width: 10)],
    );
  }
  return Container();
}

Widget _buildtrailingIcon(Widget trailingIcon) {
  if (trailingIcon != null) {
    return Row(
      children: <Widget>[
        SizedBox(width: 10),
        trailingIcon,
      ],
    );
  }
  return Container();
}
