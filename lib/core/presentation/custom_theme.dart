import 'package:flutter/material.dart';

class CustomTheme {
  static const PRIMARY_COLOR = Colors.blueGrey;
  static const ACCENT_COLOR = Colors.yellow;
  static const ERROR_COLOR = Colors.red;
  static const DISABLED_COLOR = Colors.grey;
  static const DARK_BACKGROUND_COLOR = Color(0xFF222222);
  //? TODO: not used in theme data
  static const SUCCESS_COLOR = Colors.green;
  static const WARNING_COLOR = Colors.orange;

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      dividerColor: DISABLED_COLOR,
      scaffoldBackgroundColor: DARK_BACKGROUND_COLOR,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: DISABLED_COLOR),
        filled: true,
        fillColor: Color.fromRGBO(0, 0, 0, 0.5),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ERROR_COLOR),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ERROR_COLOR),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      cardColor: DARK_BACKGROUND_COLOR,
      textTheme: TextTheme(),
      errorColor: ERROR_COLOR,
      disabledColor: DISABLED_COLOR,
      highlightColor: Color(0xFF000000).withOpacity(0.75),
      primaryColor: PRIMARY_COLOR,
      accentColor: ACCENT_COLOR,
      backgroundColor: DARK_BACKGROUND_COLOR,
      canvasColor: PRIMARY_COLOR,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.black,
      ),
    );
  }
}
