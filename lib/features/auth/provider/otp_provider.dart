import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'otp_provider.g.dart';

class OtpState {
  final String otp;
  final bool isVerifying;
  final String? errorMessage;

  OtpState({this.otp = '', this.isVerifying = false, this.errorMessage});

  OtpState copyWith({String? otp, bool? isVerifying, String? errorMessage}) {
    return OtpState(
      otp: otp ?? this.otp,
      isVerifying: isVerifying ?? this.isVerifying,
      errorMessage: errorMessage,
    );
  }
}

@riverpod
class Otp extends _$Otp {
  @override
  OtpState build() {
    return OtpState();
  }

  void setOtp(String otp) {
    state = state.copyWith(otp: otp);
  }

  Future<bool> verifyOtp() async {
    if (state.otp.length != 6) {
      state = state.copyWith(errorMessage: 'Please enter a valid 6-digit OTP');
      return false;
    }

    state = state.copyWith(isVerifying: true);

    try {
      // Simulate verification with delay
      await Future.delayed(const Duration(seconds: 1));

      // Since we're accepting any OTP, we'll just return success
      state = state.copyWith(isVerifying: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isVerifying: false,
        errorMessage: 'Verification failed: ${e.toString()}',
      );
      return false;
    }
  }

  void resetError() {
    state = state.copyWith(errorMessage: null);
  }

  Future<void> resendOtp() async {
    // Simulate OTP resend
    await Future.delayed(const Duration(seconds: 1));
  }
}
