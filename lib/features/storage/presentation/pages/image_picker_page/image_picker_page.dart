import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/custom_page_route.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_image_picker.dart';
import 'package:flutter_architecture/core/presentation/widgets/custom_safe_area.dart';

class ImagePickerPage extends StatelessWidget {
  static const routeName = PageType.imagePicker;

  final bool isPickImageAvailable;
  final bool isTakePhotoAvailable;
  final bool isCropAvailable;

  const ImagePickerPage({
    Key key,
    this.isPickImageAvailable = true,
    this.isTakePhotoAvailable = true,
    this.isCropAvailable = true,
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
          CustomImagePicker(
            isPickImageAvailable: isPickImageAvailable,
            isTakePhotoAvailable: isTakePhotoAvailable,
            isCropAvailable: isCropAvailable,
            isToggleButton: true,
          ),
        ],
      ),
    );
  }
}
