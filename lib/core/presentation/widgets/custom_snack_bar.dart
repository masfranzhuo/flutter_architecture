import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/custom_theme.dart';

enum SnackBarMode { success, error, generic }

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    Key key,
    Widget content,
    SnackBarAction action,
    Duration duration,
    String message,
    SnackBarMode mode = SnackBarMode.generic,
  }) : super(
          key: key,
          content: Builder(
            builder: (context) =>
                content ??
                Text(
                  message ?? '',
                  style: TextStyle(color: _color(context, mode)),
                ),
          ),
          action: action,
          duration: duration ?? Duration(seconds: 4),
        );
  static Color _color(BuildContext context, SnackBarMode mode) {
    switch (mode) {
      case SnackBarMode.success:
        return CustomTheme.successColor;
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
