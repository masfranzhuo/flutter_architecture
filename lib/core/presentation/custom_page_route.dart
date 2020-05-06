import 'package:flutter/widgets.dart';

enum AppPageType {
  login,
  register,
}

enum AppPageFormType { create, read, update }

class CustomPageRoute<T> extends PageRouteBuilder<T> {
  CustomPageRoute.slide({
    Offset begin = const Offset(1, 0),
    Offset end = Offset.zero,
    @required Widget page,
    @required AppPageType pageType,
  }) : super(
          transitionDuration: Duration(milliseconds: 400),
          opaque: true,
          pageBuilder: (BuildContext context, __, ___) => page,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation, __, Widget child) {
            var curveTween = CurveTween(curve: Curves.easeInOutExpo);
            var tween = Tween(begin: begin, end: end).chain(curveTween);
            var offsetAnimation = animation.drive(tween);

            return new SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          settings: RouteSettings(name: pageType.toString()),
        );

  CustomPageRoute.fade({
    @required Widget page,
    @required AppPageType pageType,
  }) : super(
          transitionDuration: Duration(milliseconds: 400),
          opaque: true,
          pageBuilder: (BuildContext context, _, __) => page,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation, __, Widget child) {
            return new FadeTransition(opacity: animation, child: child);
          },
          settings: RouteSettings(name: pageType.toString()),
        );
}
