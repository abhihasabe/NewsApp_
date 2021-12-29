import 'package:form_validation/theme/app_constant.dart';
import 'package:form_validation/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {
  final TextInputType textInputType;
  final String hintText;
  final String errorText;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final bool showSuffixIcon;
  final String defaultText;
  final FocusNode focusNode;
  final bool obscureText;
  final TextEditingController controller;
  final Function functionValidate;
  final String parametersValidate;
  final TextInputAction actionKeyboard;
  final Function onSubmitField;
  final Function onFieldTap;
  final TextCapitalization textCapitalization;
  final int maxLine;
  final ValueChanged<String> onChanged;
  final AutovalidateMode autoValidateMode;

  const TextFormFieldWidget(
      {@required this.hintText,
      this.autoValidateMode,
      this.errorText,
      this.focusNode,
      this.textInputType,
      this.defaultText,
      this.onChanged,
      this.obscureText = false,
      this.showSuffixIcon = false,
      this.controller,
      this.functionValidate,
      this.parametersValidate,
      this.actionKeyboard = TextInputAction.next,
      this.onSubmitField,
      this.onFieldTap,
      this.prefixIcon,
      this.maxLine,
      this.suffixIcon,
      this.textCapitalization});

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  double bottomPaddingToError = 12;
  bool _obSecure;
  int inputLength = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obSecure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const Key('textField'),
      autovalidateMode: widget.autoValidateMode,
      cursorColor: primaryColor,
      obscureText: _obSecure,
      textCapitalization: widget.textCapitalization,
      keyboardType: widget.textInputType,
      textInputAction: widget.actionKeyboard,
      focusNode: widget.focusNode,
      maxLines: widget.maxLine,
      style: TextStyle(
        color: textColor,
        fontSize: 16.0,
        fontWeight: FontWeight.w200,
        fontStyle: FontStyle.normal,
        letterSpacing: 1.2,
      ),
      initialValue: widget.defaultText,
      decoration: InputDecoration(
        errorText: widget.errorText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.showSuffixIcon
            ? (_obSecure
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obSecure = false;
                      });
                    },
                    icon: Icon(Icons.visibility_off,
                        size: 18, color: hoverColorDarkColor))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        _obSecure = true;
                      });
                    },
                    icon: Icon(Icons.visibility,
                        size: 18, color: hoverColorDarkColor)))
            : null,
        label: Text(
          widget.hintText,
          style: TextStyle(color: hoverColorDarkColor),
        ),
        hintText: widget.hintText,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: hoverColorDarkColor)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
        hintStyle: TextStyle(
          color: backgroundDarkColor,
          fontSize: 14.0,
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.2,
        ),
        contentPadding: EdgeInsets.only(
            top: 12, bottom: bottomPaddingToError, left: 8.0, right: 8.0),
        isDense: true,
        errorStyle: TextStyle(
          color: fentRed,
          fontSize: 12.0,
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.2,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: fentRed),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: fentRed),
        ),
      ),
      onChanged: _onChanged,
      controller: widget.controller,
      validator: (value) {
        if (widget.functionValidate != null) {
          String resultValidate =
              widget.functionValidate(value, widget.parametersValidate);
          if (resultValidate != null) {
            return resultValidate;
          }
        }
        return null;
      },
      onFieldSubmitted: (value) {
        if (widget.onSubmitField != null) widget.onSubmitField();
      },
      onTap: () {
        if (widget.onFieldTap != null) widget.onFieldTap();
      },
    );
  }

  void _setInputLength(int length) {
    setState(() {
      inputLength = length;
    });
  }

  void _onChanged(String value) {
    _setInputLength(value != AppStrings.emptyString ? value.length : 0);
    widget.onChanged(value);
  }
}

commonValidation(String value, String messageError) {
  var required = requiredValidator(value, messageError);
  if (required != null) {
    return required;
  }
  return null;
}

String requiredValidator(value, messageError) {
  if (value.isEmpty) {
    return messageError;
  }
  return null;
}

void changeFocus(BuildContext context, FocusNode currentFocus,
    FocusNode passwordFocus, FocusNode confirmPasswordFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(passwordFocus);
}
