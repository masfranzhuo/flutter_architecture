import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_button.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_safe_area.dart';

part 'image_picker.w.dart';

class ImagePickerPage extends StatelessWidget {
  final bool isPickImageAvailable;
  final bool isTakePhotoAvailable;

  const ImagePickerPage({
    Key key,
    this.isPickImageAvailable = true,
    this.isTakePhotoAvailable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      isLoading: false,
      child: Scaffold(
        body: LayoutBuilder(builder: _buildBody),
      ),
    );
  }

  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      child: ListView(
        children: <Widget>[
          _$ImagePicker(
            isPickImageAvailable: isPickImageAvailable,
            isTakePhotoAvailable: isTakePhotoAvailable,
          ),
        ],
      ),
    );
  }
}
