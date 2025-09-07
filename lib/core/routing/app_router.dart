import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:tarkiz/core/routing/app_routes.dart';
import 'package:tarkiz/features/auth/screen/loading_screen.dart';
import 'package:tarkiz/features/auth/screen/login_screen.dart';
import 'package:tarkiz/features/auth/screen/otp_verification_screen.dart';
import 'package:tarkiz/features/auth/screen/register_screen.dart';
import 'package:tarkiz/features/auth/screen/success_screen.dart';

class AppRouter {
  static final navKey = GlobalKey<NavigatorState>(debugLabel: 'navigatorKey');

  GoRouter router;

  AppRouter(AppRoute initialLocation) : router = _createRouter(initialLocation);

  static GoRouter _createRouter(AppRoute initialLocation) {
    return GoRouter(
      routes: [
        // Define your routes here
        GoRoute(
          path: AppRoute.login.path,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: AppRoute.register.path,
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: AppRoute.loading.path,
          builder: (context, state) => const TarkizLoadingScreen(),
        ),

        GoRoute(
          path: AppRoute.registerOtpVerification.path,
          name: AppRoute.registerOtpVerification.name,
          builder: (context, state) {
            // Get the passed email and phone number parameters
            final Map<String, dynamic>? extraData =
                state.extra as Map<String, dynamic>?;
            final String email = extraData?['email'] ?? '';
            final String phoneNumber = extraData?['phoneNumber'] ?? '';

            return OtpVerificationScreen(
              email: email,
              phoneNumber: phoneNumber,
            );
          },
        ),
        GoRoute(
          path: AppRoute.success.path,
          builder: (context, state) => const SuccessScreen(
            title: 'Account Successful!',
            message:
                'Your account is ready. Let\'s begin for a better HRMS experience.',
          ),
        ),
      ],
      initialLocation: initialLocation.path,
      debugLogDiagnostics: true,
      navigatorKey: navKey,
    );
  }

  void dispose() {
    router.dispose();
  }
}
