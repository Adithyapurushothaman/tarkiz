import 'package:flutter/material.dart';

/// App color palette extracted from the design
class Palette {
  // Primary Brand Colors (Gradient)
  static const Color primary = Color(0xFF3DCAD3); // Teal
  static const Color secondary = Color.fromARGB(255, 236, 244, 244);
  static const Color primaryLight = Color(0xFF74E8ED);
  static const Color primaryLighter = Color(0xFF9DF3F7); // Aqua

  // Backgrounds
  static const Color background = Color.fromARGB(
    255,
    116,
    200,
    211,
  ); // Light Cyan
  static const Color surface = Colors.white;
  // Card/containers

  // Text Colors
  static const Color textPrimary = Color(0xFF333333); // Main text
  static const Color textSecondary = Color(0xFF666666); // Subtext
  static const Color textHint = Color(0xFF999999); // Placeholder text

  // Status Colors
  static const Color success = Color(0xFF4CAF50); // Green check
  static const Color error = Color(0xFFE53935); // Red
  static const Color warning = Color(0xFFFFC107); // Amber

  // Neutral Shades
  static const Color greyLight = Color(0xFFEEEEEE);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color greyDark = Color(0xFF424242);
  static const Color black = Colors.black;
  static const Color green = Color(0xFF0D5661);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient loadingGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primaryLighter, // Light cyan at top
      primaryLight, // Medium cyan in middle
      primary, // Tarkiz brand teal at bottom
    ],
    stops: [0.0, 0.5, 1.0],
  );

  // Success screen gradient (lighter)
  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFD2F9FB), // Very light cyan at top
      Color(0xFFB7F4F7), // Light cyan in middle
      primaryLighter, // Medium cyan at bottom
    ],
    stops: [0.0, 0.5, 1.0],
  );

  // Add this gradient to your Palette class

  // Button gradient
  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF63C9C4), // Lighter teal (#63C9C4)
      Color(0xFF18B0BA), // Darker teal (#18B0BA)
    ],
  );
  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF18B0BA),
      Color(0xFF63C9C4),
      Colors.white, // Lighter teal (#63C9C4)
      // Darker teal (#18B0BA)
    ],
    stops: const [0.0, 0.65, 1.0],
  );

  // Button colors
  static const Color buttonText = Colors.white;
}
