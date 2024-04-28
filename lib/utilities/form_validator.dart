import 'package:final_project/utilities/constants.dart';

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
}
