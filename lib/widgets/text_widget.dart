import 'package:flutter/material.dart';
import 'package:form_validation/theme/app_colors.dart';
import 'package:form_validation/theme/app_dimens.dart' as dimens;
import 'package:form_validation/theme/app_colors.dart' as dimens;

class TextWidget extends StatelessWidget {
  final String text;
  final bool title;
  final bool bold;
  final bool big;
  final bool medium;
  final bool small;
  final bool smaller;
  final bool center;
  final bool white;
  final bool dark;
  final bool accent;
  final bool primary;
  final Color color;
  final int maxLines;
  final bool underline;
  final TextAlign align;

  const TextWidget({Key key, this.align, this.underline, this.text, this.title, this.bold, this.big, this.medium, this.small ,this.smaller , this.center, this.white, this.dark, this.accent, this.primary, this.color, this.maxLines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dynamic isBold = bold == true ? FontWeight.bold : FontWeight.normal;

    final String textValue = text ?? "";

    final double fontSize = title == true ? dimens.fontTextTitle
        : big == true ? dimens.fontTextBig
          : big == true ? dimens.fontTextMedium
            : small == true ? dimens.fontTextSmall
              : smaller == true ? dimens.fontTextSmaller
                : dimens.fontTextMedium;

    final Color customColor = primary == true ? primaryColor : white == true ? Colors.white : accent == true
        ? accentColor : primaryColor;
    return Text(
      textValue,
      maxLines: maxLines,
      textAlign: center == true ? TextAlign.center : align == null ? null : align,
      style: TextStyle(
        decoration: underline == true ? TextDecoration.underline : TextDecoration.none,
        fontSize: fontSize, fontFamily: 'Roboto',
        color: color == null ? dark == true ? backgroundColor : customColor : color, fontWeight: isBold
      )
    );
  }
}