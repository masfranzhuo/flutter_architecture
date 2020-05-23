import 'package:flutter/material.dart';

class OpacityAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double beginOpacity;
  final double endOpacity;

  const OpacityAnimation({
    Key key,
    @required this.child,
    @required this.duration,
    this.beginOpacity = 0,
    this.endOpacity = 1,
  }) : super(key: key);

  @override
  _OpacityAnimationState createState() => _OpacityAnimationState();
}

class _OpacityAnimationState extends State<OpacityAnimation>
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
      begin: widget.beginOpacity ?? 0,
      end: widget.endOpacity ?? 1,
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
        return AnimatedOpacity(
          opacity: animation.value,
          duration: widget.duration,
          child: child,
        );
      },
    );
  }
}