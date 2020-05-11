import 'package:flutter/material.dart';
import 'package:flutter_architecture/main.dart';

enum SnackBarMode { success, error, generic }

class CustomSnackBar {
  static void showSnackBar({
    @required BuildContext context,
    @required String message,
    Widget content,
    Color backgroundColor,
    SnackBarMode mode = SnackBarMode.generic,
  }) {
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: content ??
              Text(
                message,
                style: TextStyle(color: _color(context, mode)),
              ),
        ),
      );
  }

  static Color _color(BuildContext context, SnackBarMode mode) {
    switch (mode) {
      case SnackBarMode.success:
        return SUCCESS_COLOR;
        break;
      case SnackBarMode.error:
        return Theme.of(context).errorColor;
        break;
      default:
        return Theme.of(context).primaryColor;
        break;
    }
  }
}
