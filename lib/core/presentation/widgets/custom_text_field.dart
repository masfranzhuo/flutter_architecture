import 'package:flutter/material.dart';

class CustomTextField extends TextField {
  CustomTextField({
    Key key,
    @required BuildContext context,
    @required String hintText,
    bool obscureText = false,
    bool readOnly = false,
    TextCapitalization textCapitalization = TextCapitalization.none,
    IconData iconData,
    TextEditingController controller,
    TextInputType keyboardType,
    String errorText,
    Widget prefixIcon,
    Widget suffixIcon,
    String prefixText,
    String suffixText,
    int maxLength,
    FocusNode focusNode,
  }) : super(
          key: key,
          readOnly: readOnly,
          obscureText: obscureText,
          keyboardType: keyboardType,
          controller: controller,
          autofocus: false,
          textCapitalization: textCapitalization,
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
            errorText: errorText,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            icon: iconData != null
                ? Icon(
                    iconData,
                    color: Theme.of(context).primaryColor,
                  )
                : null,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            prefixText: prefixText,
            suffixText: suffixText,
            hintText: hintText,
            border: InputBorder.none,
            counterText: '',
          ),
          maxLength: maxLength,
          focusNode: focusNode,
        );
}
