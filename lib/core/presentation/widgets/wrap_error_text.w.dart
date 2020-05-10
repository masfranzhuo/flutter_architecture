import 'package:flutter/material.dart';

class WrapErrorText extends StatelessWidget {
  final Widget child;
  final String errorText;
  final IconData iconData;

  const WrapErrorText({
    Key key,
    @required this.child,
    this.errorText,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget errorTextWidget = SizedBox();
    if (errorText != null) {
      double errorTextLeftPadding = iconData != null ? 56 : 16;
      errorTextWidget = Padding(
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

    Widget iconDataWidget = SizedBox();
    if (iconData != null) {
      iconDataWidget = Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Icon(
          iconData,
          color: Theme.of(context).primaryColor,
        ),
      );
    }

    BoxDecoration errorBoxDecoration = errorText != null
        ? BoxDecoration(
            border: Border.all(color: Theme.of(context).errorColor),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          )
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            iconDataWidget,
            Expanded(
              child: Container(
                decoration: errorBoxDecoration,
                child: child,
              ),
            ),
          ],
        ),
        errorTextWidget,
      ],
    );
  }
}
