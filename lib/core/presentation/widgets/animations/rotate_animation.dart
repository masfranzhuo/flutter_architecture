import 'package:flutter/material.dart';
import 'dart:math' as math;

enum Direction { clockwise, counterClockwise }

class RotateAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final int turn;
  final Direction direction;

  const RotateAnimation(
      {Key key,
      @required this.child,
      @required this.duration,
      this.turn = 1,
      this.direction = Direction.clockwise})
      : super(key: key);

  @override
  _RotateAnimationState createState() => _RotateAnimationState();
}

class _RotateAnimationState extends State<RotateAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    animation = Tween<double>(
      begin: 0,
      end: 2 *
          math.pi *
          (widget.direction == Direction.clockwise
              ? widget.turn
              : -widget.turn),
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
        return Transform.rotate(
          angle: animation.value,
          child: child,
        );
      },
    );
  }
}
