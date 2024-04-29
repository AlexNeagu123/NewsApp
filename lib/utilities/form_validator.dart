import 'package:final_project/utilities/constants.dart';
import 'package:flutter/material.dart';

class FormValidator {
  const FormValidator._();
  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return ErrorMessages.emailEmpty;
    }
    if (!RegExp(StringConstants.emailRegex).hasMatch(email)) {
      return ErrorMessages.invalidEmail;
    }
    return null;
  }

  static String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return ErrorMessages.passwordEmpty;
    }
    return null;
  }

  static String? confirmPasswordValidator(
      String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return ErrorMessages.confirmPasswordEmpty;
    }
    if (password != confirmPassword) {
      return ErrorMessages.passwordsDoNotMatch;
    }
    return null;
  }

  static Future<void> showAlertDialog(
      String errorTitle, String errorMessage, BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(errorTitle),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            )
          ],
        );
      },
    );
  }
}
