
import 'package:flutter/material.dart';

class CustomTheme {
  static Color primaryColor = Colors.blueGrey;
  static Color accentColor = Colors.yellow;
  static Color backgroundColor = Color(0xFF222222);
  static Color fillColor = Color(0X88000000);
  static Color highlightColor = Color(0XDD000000);
  static Color disabledColor = Colors.grey;
  static Color errorColor = Colors.red;

  /// other color not in theme
  /// could be accessed directly
  static Color successColor = Colors.green;

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      dividerColor: disabledColor,
      scaffoldBackgroundColor: backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: disabledColor),
        filled: true,
        fillColor: fillColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorColor),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      cardColor: backgroundColor,
      textTheme: TextTheme(),
      errorColor: errorColor,
      disabledColor: disabledColor,
      highlightColor: highlightColor,
      primaryColor: primaryColor,
      accentColor: accentColor,
      backgroundColor: backgroundColor,
      canvasColor: primaryColor,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.black,
      ),
    );
  }

  static ThemeData light() {
    primaryColor = Color(0xFFA6B1E1);
    accentColor = Color(0xFF424874);
    backgroundColor = Colors.white;
    fillColor = Color(0X88DDDDDD);
    highlightColor = Color(0XDDFFFFFF);
    errorColor = Colors.orange;

    return ThemeData(
      brightness: Brightness.light,
      dividerColor: disabledColor,
      scaffoldBackgroundColor: backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: disabledColor),
        filled: true,
        fillColor: fillColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorColor),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      cardColor: backgroundColor,
      textTheme: TextTheme(),
      errorColor: errorColor,
      disabledColor: disabledColor,
      highlightColor: highlightColor,
      primaryColor: primaryColor,
      accentColor: accentColor,
      backgroundColor: backgroundColor,
      canvasColor: primaryColor,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.black,
      ),
    );
  }
}
