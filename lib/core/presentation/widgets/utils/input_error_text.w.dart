import 'package:flutter/material.dart';

class InputErrorText extends StatelessWidget {
  final String errorText;
  final bool isIconAvailable;

  const InputErrorText({
    Key key,
    @required this.errorText,
    this.isIconAvailable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget widget = SizedBox();
    if (errorText != null) {
      double errorTextLeftPadding = isIconAvailable ? 56 : 16;
      widget = Padding(
        padding: EdgeInsets.fromLTRB(errorTextLeftPadding, 8, 8, 0),
        child: Text(
          errorText,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.caption.copyWith(
                color: Theme.of(context).errorColor,
              ),
        ),
      );
    }

    return widget;
  }
}
