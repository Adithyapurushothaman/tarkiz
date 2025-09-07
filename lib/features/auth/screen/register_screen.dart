import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tarkiz/core/constants/strings.dart';
import 'package:tarkiz/core/routing/app_routes.dart';
import 'package:tarkiz/core/theme/palette.dart';
import 'package:tarkiz/core/utils/validation/email_validation.dart';
import 'package:tarkiz/core/utils/validation/password_validation.dart';
import 'package:tarkiz/core/utils/validation/phone_validation.dart';
import 'package:tarkiz/core/widgets/custom_input_field.dart';
import 'package:tarkiz/features/auth/provider/auth_provider.dart';
import 'package:tarkiz/features/auth/widget/header_widget.dart';
import 'package:tarkiz/features/auth/widget/auth_toggle.dart';
import 'package:tarkiz/features/auth/widget/primary_button.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _workEmailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  bool _obscureText = true;

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _mobileFocusNode = FocusNode();

  @override
  void dispose() {
    _workEmailController.dispose();
    _passwordController.dispose();
    _mobileNumberController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _mobileFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Add listeners to update the Riverpod state when text changes
    _workEmailController.addListener(_updateWorkEmail);
    _passwordController.addListener(_updatePassword);
    _mobileNumberController.addListener(_updateMobileNumber);
  }

  void _updateWorkEmail() {
    ref.read(authProvider.notifier).updateWorkEmail(_workEmailController.text);
  }

  void _updatePassword() {
    ref.read(authProvider.notifier).updatePassword(_passwordController.text);
  }

  void _updateMobileNumber() {
    ref
        .read(authProvider.notifier)
        .updateMobileNumber(_mobileNumberController.text);
  }

  Future<void> _validateAndProceed() async {
    // Manually trigger validation
    final emailError = validateEmail(_workEmailController.text);
    final passwordError = validatePassword(_passwordController.text);
    final mobileError = validateMobileNumber(_mobileNumberController.text);

    // If any validation fails, focus the first field with an error
    if (emailError != null) {
      _emailFocusNode.requestFocus();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(emailError),
          backgroundColor: Palette.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (passwordError != null) {
      _passwordFocusNode.requestFocus();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(passwordError),
          backgroundColor: Palette.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (mobileError != null) {
      _mobileFocusNode.requestFocus();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(mobileError),
          backgroundColor: Palette.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Get the current text values directly from controllers
    final email = _workEmailController.text;
    final password = _passwordController.text;
    final mobileNumber = _mobileNumberController.text;

    final authNotifier = ref.read(authProvider.notifier);

    // Pass the current values to the register method
    final success = await authNotifier.register(email, password, mobileNumber);

    if (success) {
      if (mounted) {
        // Navigate to OTP verification with the entered data
        context.go(
          AppRoute.registerOtpVerification.path,
          extra: {'email': email.trim(), 'phoneNumber': mobileNumber.trim()},
        );
      }
    } else {
      // Error message will be shown in the UI via the consumer
      if (mounted) {
        final errorMessage = ref.read(authProvider).errorMessage;
        if (errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Palette.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
          authNotifier.resetError();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch the auth state for changes
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: Palette.surface,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Add the WelcomeHeader at the top - matching OTP verification screen
            const WelcomeHeader(
              title: AppStrings.registrationTitle,
              subtitle: AppStrings.registrationSubtitle,
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Auth toggle for switching between login and register
                  AuthToggle(
                    isLoginSelected: false,
                    onLoginTap: () => context.go(AppRoute.login.path),
                    onRegisterTap: () {},
                  ),

                  const SizedBox(height: 30),

                  // Work Email - using CustomInputField
                  CustomInputField(
                    controller: _workEmailController,
                    labelText: AppStrings.workEmail,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _emailFocusNode,
                    validator: validateEmail,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => _passwordFocusNode.requestFocus(),
                  ),
                  const SizedBox(height: 16),

                  // Password - using CustomInputField
                  CustomInputField(
                    controller: _passwordController,
                    labelText: AppStrings.password,
                    obscureText: _obscureText,
                    focusNode: _passwordFocusNode,
                    validator: validatePassword,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => _mobileFocusNode.requestFocus(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Palette.textHint,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Mobile number - using CustomInputField
                  CustomInputField(
                    controller: _mobileNumberController,
                    labelText: AppStrings.mobileNumber,
                    keyboardType: TextInputType.phone,
                    focusNode: _mobileFocusNode,
                    validator: validateMobileNumber,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _validateAndProceed(),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text('🇦🇪', style: TextStyle(fontSize: 20)),
                          SizedBox(width: 4),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 18,
                            color: Palette.textHint,
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 150),

                  // Terms and conditions
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Palette.textPrimary,
                        fontSize: 12,
                      ),
                      children: [
                        const TextSpan(text: AppStrings.termsConditions),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      // Back button
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: authState.isLoading
                              ? null
                              : () => context.go(AppRoute.login.path),
                          icon: const Icon(Icons.arrow_back, size: 16),
                          label: const Text(AppStrings.back),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Palette.greyDark,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: BorderSide(color: Palette.greyLight),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Register button with loading state
                      Expanded(
                        child: authState.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Palette.primary,
                                ),
                              )
                            : PrimaryButton(
                                text: AppStrings.register,
                                onPressed: _validateAndProceed,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
