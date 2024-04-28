class ErrorMessages {
  static const String emailEmpty = "Email cannot be empty";
  static const String invalidEmail = "Invalid email format";
  static const String passwordEmpty = "Password cannot be empty";
  static const String confirmPasswordEmpty = "Confirm password cannot be empty";
  static const String passwordsDoNotMatch = "Passwords do not match";
}

class StringConstants {
  static const String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
}
