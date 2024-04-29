class ErrorMessages {
  static const String emailEmpty = "Email cannot be empty";
  static const String invalidEmail = "Invalid email format";
  static const String passwordEmpty = "Password cannot be empty";
  static const String confirmPasswordEmpty = "Confirm password cannot be empty";
  static const String passwordsDoNotMatch = "Passwords do not match";
  static const String invalidCredentials = "Incorrect credentials";
  static const String unknownError = "Unknown error";
  static const String invalidDetails = "Invalid details";
}

class StringConstants {
  static const String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
}
