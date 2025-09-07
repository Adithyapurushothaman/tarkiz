import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tarkiz/core/constants/strings.dart';
import 'package:tarkiz/core/routing/app_routes.dart';
import 'package:tarkiz/core/theme/palette.dart';

class AuthToggle extends StatelessWidget {
  final bool isLoginSelected;
  final VoidCallback onLoginTap;
  final VoidCallback onRegisterTap;

  const AuthToggle({
    super.key,
    required this.isLoginSelected,
    required this.onLoginTap,
    required this.onRegisterTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Palette.greyLight, // Light gray background
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                onLoginTap();
                context.go(AppRoute.login.path);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  // Use gradient when selected, otherwise transparent
                  gradient: isLoginSelected ? Palette.buttonGradient : null,
                  color: isLoginSelected ? null : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  AppStrings.login,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isLoginSelected ? Palette.surface : Palette.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                onRegisterTap();
                context.go(AppRoute.register.path);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  // Use gradient when selected, otherwise transparent
                  gradient: !isLoginSelected ? Palette.buttonGradient : null,
                  color: !isLoginSelected ? null : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  AppStrings.register,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: !isLoginSelected ? Palette.surface : Palette.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
