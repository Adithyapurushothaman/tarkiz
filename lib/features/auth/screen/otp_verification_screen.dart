import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:tarkiz/core/constants/strings.dart';
import 'package:tarkiz/core/routing/app_routes.dart';
import 'package:tarkiz/core/theme/palette.dart';
import 'package:tarkiz/features/auth/provider/otp_provider.dart';
import 'package:tarkiz/features/auth/widget/header_widget.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  final String email;
  final String phoneNumber;

  const OtpVerificationScreen({
    super.key,
    required this.email,
    required this.phoneNumber,
  });

  @override
  ConsumerState<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  bool isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
      });
    });
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _verifyOtp(String pin) {
    final otpNotifier = ref.read(otpProvider.notifier);
    otpNotifier.setOtp(pin);

    // Start verification
    _processOtp();
  }

  Future<void> _processOtp() async {
    final otpNotifier = ref.read(otpProvider.notifier);
    final success = await otpNotifier.verifyOtp();

    if (success && mounted) {
      // Navigate to loading screen
      context.go(AppRoute.loading.path);
    } else if (mounted) {
      // Show error if verification failed
      final errorMessage = ref.read(otpProvider).errorMessage;
      if (errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
        otpNotifier.resetError();
      }
    }
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => context.go(AppRoute.register.path),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_back_ios, size: 14, color: Colors.black54),
          SizedBox(width: 4),
          Text(
            AppStrings.backToLogin,
            style: TextStyle(color: Colors.black54, fontSize: 14),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Check if keyboard is visible on each build
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final isKeyboardVisibleNow = keyboardHeight > 0;

    // Update state if keyboard visibility changed
    if (isKeyboardVisible != isKeyboardVisibleNow) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          isKeyboardVisible = isKeyboardVisibleNow;
        });
      });
    }

    const length = 6;
    final defaultPinTheme = PinTheme(
      width: 48,
      height: 48,
      textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Palette.greyLight),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: Palette.primary, width: 2),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        gradient: Palette.buttonGradient,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Palette.primary),
      ),
      textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color:
            Palette.secondary, // Change text color to white for better contrast
      ),
    );

    // Watch the OTP state for changes
    final otpState = ref.watch(otpProvider);

    // Create a custom subtitle that includes the user's contact information
    final String contactInfo =
        widget.email.isNotEmpty || widget.phoneNumber.isNotEmpty
        ? 'Code sent to ${widget.email} ${widget.phoneNumber.isNotEmpty ? "or ${widget.phoneNumber}" : ""}'
        : 'Enter the verification code';

    return Scaffold(
      backgroundColor: Palette.surface,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Add the WelcomeHeader at the top
          WelcomeHeader(title: AppStrings.otpTitle, subtitle: contactInfo),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),

                        // Pinput widget with dash separator
                        Pinput(
                          length: length,
                          controller: pinController,
                          focusNode: focusNode,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          submittedPinTheme: submittedPinTheme,
                          pinAnimationType: PinAnimationType.slide,
                          enabled: !otpState.isVerifying,
                          separatorBuilder: (index) {
                            return index == 2
                                ? const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: Text(
                                      '-',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Palette.primary,
                                      ),
                                    ),
                                  )
                                : const SizedBox(width: 8);
                          },
                          onCompleted: _verifyOtp,
                        ),

                        const SizedBox(height: 20),

                        // Conditional UI based on verification state
                        otpState.isVerifying
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Palette.primary,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    AppStrings.verifying,
                                    style: TextStyle(
                                      color: Palette.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    AppStrings.otpNotReceived,
                                    style: TextStyle(
                                      color: Palette.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Handle resend OTP logic
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            AppStrings.otpResentSuccessMessage,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      AppStrings.resendOtp,
                                      style: TextStyle(
                                        color: Palette.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                        // Place back button right after resend OTP when keyboard is visible
                        if (isKeyboardVisible && !otpState.isVerifying)
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: _buildBackButton(),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Place back button at the bottom when keyboard is not visible
          if (!isKeyboardVisible && !otpState.isVerifying)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _buildBackButton(),
            ),
        ],
      ),
      // Important: this prevents the whole screen from resizing when keyboard appears
      resizeToAvoidBottomInset: false,
    );
  }
}
