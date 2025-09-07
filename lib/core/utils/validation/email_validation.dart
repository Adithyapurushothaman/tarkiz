/// Validates the given email and returns an error message if invalid.
///
/// Returns:
/// - [AppStrings.emailEmpty] if the email is empty.
/// - [AppStrings.emailInvalid] if the email format is invalid.
/// - `null` if the email is valid.
String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return "Email cannot be empty";
  }
  // zod regex to match email
  // This regex enforces the following rules:
  // - Must start with one or more letters, numbers, or allowed special characters
  // - Must not contain two consecutive periods
  // - User must not end with a period or single quote
  // - Must contain '@' symbol
  // - Must have valid domain name after '@'
  // - Domain must have at least one period
  //
  // Example valid emails:
  // - user@example.com
  // - user.name@domain.co.uk
  final emailRegex = RegExp(
    r"^(?!\.)(?!.*\.\.)([A-Z0-9_'+\-\.]*)[A-Z0-9_+-]@([A-Z0-9][A-Z0-9\-]*\.)+[A-Z]{2,}$",
    caseSensitive: false,
  );
  if (!emailRegex.hasMatch(email)) {
    return "Invalid email format";
  }
  return null;
}
