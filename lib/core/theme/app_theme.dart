import 'package:flutter/material.dart';

class AppTheme {
  // Primary palette
  static const Color primaryColor = Color(0xFF3DCAD3); // Teal #3DCAD3
  static const Color secondaryColor = Color(0xFF63C9C4); // Aqua #63C9C4
  static const Color accentColor = Color(0xFF1FBEC9); // Bright teal #1FBEC9

  // Background colors
  static const Color backgroundColor = Color(0xFFE9F9FB); // Light cyan
  static const Color surfaceColor = Colors.white;

  // Text colors
  static const Color textPrimary = Color(0xFF333333); // Dark text
  static const Color textSecondary = Color(0xFF666666); // Gray text
  static const Color textHint = Color(0xFF999999); // Hint text

  // State colors
  static const Color successColor = Color(0xFF4CAF50); // Green check
  static const Color errorColor = Color(0xFFE53935); // Error red
  static const Color warningColor = Color(0xFFFFC107); // Warning amber

  // Neutrals
  static const Color white = Colors.white;
  static const Color grey = Color(0xFFCCCCCC);
  static const Color greyLight = Color(0xFFEEEEEE);

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: white,
    fontFamily: 'Roboto',

    appBarTheme: const AppBarTheme(
      backgroundColor: white,
      elevation: 0,
      iconTheme: IconThemeData(color: textPrimary),
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textPrimary, fontSize: 16),
      bodyMedium: TextStyle(color: textSecondary, fontSize: 14),
      titleLarge: TextStyle(
        color: textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: TextStyle(
        color: white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(color: textHint),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: errorColor),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        backgroundColor: primaryColor,
        foregroundColor: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        elevation: 0,
        disabledBackgroundColor: greyLight,
        disabledForegroundColor: textSecondary,
      ),
    ),

    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: accentColor,
      surface: surfaceColor,
      onSurface: textPrimary,
      onPrimary: white,
      onSecondary: white,
      background: backgroundColor,
      onBackground: textPrimary,
      error: errorColor,
      onError: white,
    ),
  );

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF3DCAD3), // #3DCAD3
      Color(0xFF63C9C4), // #63C9C4
      Color(0xFF3DCAD3), // #3DCAD3
      Color(0xFF1FBEC9), // #1FBEC9
      Color(0xFF63C9C4), // #63C9C4
      Color(0xFF3DCAD3), // #3DCAD3
      Color(0xFF1FBEC9), // #1FBEC9
    ],
    stops: [0.0, 0.16, 0.33, 0.50, 0.67, 0.84, 1.0],
  );
}
