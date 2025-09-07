String? validateMobileNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your mobile number';
  }

  final phoneRegExp = RegExp(r'^\d{9,10}$');
  if (!phoneRegExp.hasMatch(value)) {
    return 'Please enter a valid mobile number';
  }

  return null;
}
