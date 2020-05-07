import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_container.dart';
import 'package:flutter_architecture/core/presentation/widgets/loading_indicator.dart';

enum ButtonState { loading, idle, done }

class CustomButton extends StatelessWidget {
  final Function() onPressed;
  final double height;
  final double width;
  final Color color;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Widget child;
  final ButtonState state;
  final bool isFullWidth;

  const CustomButton({
    Key key,
    @required this.onPressed,
    @required this.child,
    this.height,
    this.width,
    this.color,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.margin,
    this.state = ButtonState.idle,
    this.isFullWidth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget widget = _buildWidget(context, child, state);

    if (state == ButtonState.loading) {
      widget = _buildWidget(context, LoadingIndicator(), state);
    }

    if (state == ButtonState.done) {
      widget = _buildWidget(context, Icon(Icons.check), state);
    }

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 250),
      child: widget,
    );
  }

  Widget _buildWidget(BuildContext context, Widget child, ButtonState state) {
    return CustomContainer(
      context: context,
      key: Key(state.toString()),
      margin: margin,
      padding: padding,
      width: isFullWidth ? double.infinity : width,
      height: height,
      color: color ?? Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(8),
      child: FlatButton(
        padding: const EdgeInsets.all(0),
        onPressed: () {
          onPressed();
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: child,
      ),
    );
  }
}
