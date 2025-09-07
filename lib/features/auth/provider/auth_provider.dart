import 'package:riverpod_annotation/riverpod_annotation.dart';

// This generates a file called auth_provider.g.dart
part 'auth_provider.g.dart';

// State class to hold registration data
class RegistrationState {
  final String workEmail;
  final String password;
  final String mobileNumber;
  final bool isLoading;
  final String? errorMessage;

  RegistrationState({
    this.workEmail = '',
    this.password = '',
    this.mobileNumber = '',
    this.isLoading = false,
    this.errorMessage,
  });

  RegistrationState copyWith({
    String? workEmail,
    String? password,
    String? mobileNumber,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RegistrationState(
      workEmail: workEmail ?? this.workEmail,
      password: password ?? this.password,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

// Using the @riverpod annotation to create a generated provider
@riverpod
class Auth extends _$Auth {
  @override
  RegistrationState build() {
    return RegistrationState();
  }

  void updateWorkEmail(String email) {
    state = state.copyWith(workEmail: email.trim());
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void updateMobileNumber(String number) {
    state = state.copyWith(mobileNumber: number.trim());
  }

  void resetError() {
    state = state.copyWith(errorMessage: null);
  }

  bool validateRegistration() {
    if (state.workEmail.isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter your work email');
      return false;
    }

    if (state.password.isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter your password');
      return false;
    }

    if (state.mobileNumber.isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter your mobile number');
      return false;
    }

    return true;
  }

  // This function ensures the latest field values are used directly from controllers
  bool validateRegistrationWithValues(
    String email,
    String password,
    String mobile,
  ) {
    // First, update state with the current values
    state = state.copyWith(
      workEmail: email.trim(),
      password: password,
      mobileNumber: mobile.trim(),
    );

    // Then validate using the updated state
    return validateRegistration();
  }

  Future<bool> register(String email, String password, String mobile) async {
    // Update state with latest values from controllers and validate
    if (!validateRegistrationWithValues(email, password, mobile)) {
      return false;
    }

    state = state.copyWith(isLoading: true);

    try {
      // Simulate API call with delay
      await Future.delayed(const Duration(seconds: 1));

      // Registration successful
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Registration failed: ${e.toString()}',
      );
      return false;
    }
  }
}
