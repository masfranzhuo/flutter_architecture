import 'package:flutter/material.dart';

class TranslateAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double x, y;

  const TranslateAnimation({
    Key key,
    @required this.child,
    @required this.duration,
    this.x = 1,
    this.y = 1,
  }) : super(key: key);

  @override
  _TranslateAnimationState createState() =>
      _TranslateAnimationState();
}

class _TranslateAnimationState
    extends State<TranslateAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    /// Tween is not reliable is [begin] = 0 and [end] = 1
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(animationController);

    animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: widget.child,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            animation.value * widget.x,
            animation.value * widget.y,
          ),
          child: child,
        );
      },
    );
  }
}
