import 'package:flutter/material.dart';

class ScaleAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double scale;

  const ScaleAnimation({
    Key key,
    @required this.child,
    @required this.duration,
    this.scale = 1,
  }) : super(key: key);

  @override
  _ScaleAnimationState createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<ScaleAnimation>
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
        return Transform.scale(
          scale: animation.value * widget.scale,
          child: child,
        );
      },
    );
  }
}