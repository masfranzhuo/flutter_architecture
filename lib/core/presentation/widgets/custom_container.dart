import 'package:flutter/material.dart';

class CustomContainer extends Container {
  CustomContainer({
    Key key,
    @required BuildContext context,
    double height,
    double width,
    Widget child,
    Color color,
    bool isCircle = false,
    bool isShadow = false,
    EdgeInsetsGeometry margin,
    EdgeInsetsGeometry padding,
    BorderRadius borderRadius,
  }) : super(
          key: key,
          height: height,
          width: width,
          margin: margin,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: color ?? Theme.of(context).backgroundColor,
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            boxShadow: isShadow ? [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.35),
                blurRadius: 3,
                offset: Offset(3, 3),
                spreadRadius: 1,
              ),
            ] : [],
          ),
          child: child,
        );
}
