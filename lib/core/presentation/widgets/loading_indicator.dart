import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final Color backgroundColor;
  final bool isFullScreen;

  const LoadingIndicator({
    Key key,
    this.backgroundColor,
    this.isFullScreen = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget loading = CircularProgressIndicator(
      strokeWidth: 3,
      backgroundColor: backgroundColor ?? Theme.of(context).canvasColor,
    );

    if (isFullScreen) {
      loading = Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.5,
            child: Center(
              child: Container(
                color: Colors.black,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          Center(child: loading),
        ],
      );
    }

    return loading;
  }
}
