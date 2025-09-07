import 'package:flutter/widgets.dart';

enum PasswordStrength { strong, medium, weak }

// Validates the given password and returns it's strength.
//
// Returns:
// - [passwordStrong] if it has both uppercase and lower case alphabets, digits, special characters and minimum length of 8.
// - [passwordMedium] if it has either uppercase or lower case alphabets, digits and minimum length of 8.
// - [passwordweak] in all other cases.

String checkPasswordStrength(String password) {
  final bool hasUpperCase = password.contains(RegExp(r'[A-Z]'));
  final bool hasLowerCase = password.contains(RegExp(r'[a-z]'));
  final bool hasDigits = password.contains(RegExp(r'[0-9]'));
  final bool hasSpecialChars = password.contains(
    RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
  );
  final bool hasMinLength = password.length >= 8;

  if (hasUpperCase &&
      hasLowerCase &&
      hasDigits &&
      hasSpecialChars &&
      hasMinLength) {
    return "Strong";
  } else if (hasMinLength && ((hasUpperCase || hasLowerCase) && hasDigits)) {
    return "Medium";
  } else {
    return "Weak";
  }
}

/// Validates the given password and returns an error message if invalid.
///
/// Returns:
/// - [AppStrings.passwordEmpty] if the password is empty.
/// - [AppStrings.passwordAtleast6] if the password is less than 6 characters.
/// - `null` if the password is valid.
String? validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return "Password cannot be empty";
  }
  if (password.characters.length < 6) {
    return "Password must be at least 6 characters long";
  }
  return null;
}
