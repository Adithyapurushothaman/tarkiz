import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tarkiz/core/constants/strings.dart';
import 'package:tarkiz/core/routing/app_routes.dart';
import 'package:tarkiz/core/theme/palette.dart';
import 'package:tarkiz/core/widgets/custom_input_field.dart';
import 'package:tarkiz/features/auth/widget/auth_toggle.dart';
import 'package:tarkiz/features/auth/widget/header_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _validateAndProceed() {
    // Just check if fields are not empty
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.emailCannotBeEmpty),
          backgroundColor: Palette.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      _emailFocusNode.requestFocus();
      return;
    }

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.passwordCannotBeEmpty),
          backgroundColor: Palette.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      _passwordFocusNode.requestFocus();
      return;
    }

    // If both fields are filled, proceed with navigation
    context.go(AppRoute.loading.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.surface,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Welcome Header with title and subtitle from image
            const WelcomeHeader(
              title: AppStrings.startJourneyTitle,
              subtitle: AppStrings.startJourneySubtitle,
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Using the AuthToggle widget instead of custom row
                  AuthToggle(
                    isLoginSelected: true,
                    onLoginTap: () {
                      // Already on login screen
                    },
                    onRegisterTap: () => context.go(AppRoute.register.path),
                  ),

                  const SizedBox(height: 24),

                  // Email/Username input
                  CustomInputField(
                    controller: _emailController,
                    labelText: AppStrings.emailAddress,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _emailFocusNode,

                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => _passwordFocusNode.requestFocus(),
                  ),

                  const SizedBox(height: 16),

                  // Password input
                  CustomInputField(
                    controller: _passwordController,
                    labelText: AppStrings.password,
                    obscureText: _obscureText,
                    focusNode: _passwordFocusNode,

                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => _passwordFocusNode.unfocus(),
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

                  // Forgot Password link
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Navigate to forgot password screen
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        AppStrings.forgotPassword,
                        style: TextStyle(
                          color: Palette.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Login button - gray as shown in image
                  ElevatedButton(
                    onPressed: () {
                      _validateAndProceed();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.greyLight,
                      foregroundColor: Palette.textPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      AppStrings.login,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
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
