import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final Widget child, image;

  const ImageDialog({
    Key key,
    @required this.child,
    this.image,
  }) : super(key: key);

  void showImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(child: image ?? child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: child,
      onTap: () => showImage(context),
    );
  }
}
