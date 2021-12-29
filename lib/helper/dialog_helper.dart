
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_validation/theme/app_colors.dart';

class DialogHelper {
  static SnackBar displaySnackBar(String message,
      {String actionMessage, VoidCallback onClick}) {
    return SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white, fontSize: 14.0)),
      action: (actionMessage != null)
          ? SnackBarAction(
              textColor: Colors.white,
              label: actionMessage,
              onPressed: () {
                return onClick();
              },
            )
          : null,
      duration: const Duration(seconds: 2),
      backgroundColor: primaryColor,
    );
  }

  static void dismissProgressBar(context) {
    return Navigator.pop(context);
  }

  static Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  static Future<bool> displayToast(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: primaryColor,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  static showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
