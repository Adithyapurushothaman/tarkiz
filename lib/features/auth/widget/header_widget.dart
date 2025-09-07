import 'package:flutter/material.dart';
import 'package:tarkiz/core/constants/strings.dart';
import 'package:tarkiz/core/theme/palette.dart';

class WelcomeHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final double height;
  final EdgeInsetsGeometry padding;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final TextStyle? appTitleStyle;

  const WelcomeHeader({
    super.key,
    required this.title,
    this.subtitle = '',
    this.height = 200.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
    this.titleStyle,
    this.subtitleStyle,
    this.appTitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: Palette.headerGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Image.asset('assets/icons/app_icon.png', height: 24),
              const SizedBox(width: 8),
              Text(
                AppStrings.appName,
                style:
                    appTitleStyle ??
                    theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Palette.green,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style:
                titleStyle ??
                theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Palette.black,
                ),
          ),
          if (subtitle.isNotEmpty) ...[
            Text(
              subtitle,
              style:
                  subtitleStyle ??
                  theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Palette.black,
                  ),
            ),
          ],
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
