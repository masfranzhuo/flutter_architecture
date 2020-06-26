import 'package:flutter/material.dart';

class FullScreenImagePage extends StatelessWidget {
  final Widget child;

  const FullScreenImagePage({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: SingleChildScrollView(
              scrollDirection: height > width ? Axis.horizontal : Axis.vertical,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
