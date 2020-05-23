import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/presentation/widgets/wrap_error_text.w.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

enum ImagePickerSource { gallery, camera }

class CustomImagePicker extends StatefulWidget {
  final bool isPickImageAvailable;
  final bool isTakePhotoAvailable;
  final bool isCropAvailable;
  final String imageUrl;
  final Function(File) onPicked;
  final bool readOnly;
  final String errorText;

  const CustomImagePicker({
    Key key,
    this.isPickImageAvailable = true,
    this.isTakePhotoAvailable = true,
    this.isCropAvailable = false,
    this.imageUrl,
    this.onPicked,
    this.readOnly = false,
    this.errorText,
  }) : super(key: key);

  @override
  _CustomImagePickerState createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  File _file;

  void _pickImage(ImagePickerSource imageSource) async {
    File image = await ImagePicker.pickImage(
      source: imageSource == ImagePickerSource.gallery
          ? ImageSource.gallery
          : ImageSource.camera,
    );

    if (image == null) return;

    if (widget.isCropAvailable) {
      image = await ImageCropper.cropImage(sourcePath: image.path);
    }

    setState(() {
      _file = image;
    });

    if (widget.onPicked != null) {
      widget.onPicked(_file);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    if (widget.imageUrl != null && _file == null) {
      widgets.add(_buildImageNetwork(context));
    } else {
      widgets.add(_buildImageFile(context));
    }
    widgets.add(_buildButtons(context));

    return AbsorbPointer(
      absorbing: widget.readOnly,
      child: Container(
        child: Column(
          children: widgets,
        ),
      ),
    );
  }

  Widget _buildImageFile(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: WrapErrorText(
        errorText: widget.errorText,
        child: _file != null ? Image.file(_file) : Placeholder(),
      ),
    );
  }

  Widget _buildImageNetwork(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: WrapErrorText(
        errorText: widget.errorText,
        child: FadeInImage(
          image: NetworkImage(widget.imageUrl),
          placeholder: NetworkImage(
            'https://via.placeholder.com/512x512.png?text=Image preview',
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    List<Widget> widgets = [];

    if (_file != null && widget.onPicked == null) {
      widgets.add(IconButton(
        icon: Icon(Icons.check),
        onPressed: () {
          Navigator.pop(context, _file);
        },
      ));
    }

    if (widget.isPickImageAvailable) {
      widgets.add(IconButton(
        icon: Icon(Icons.image),
        onPressed: () => _pickImage(ImagePickerSource.gallery),
      ));
    }

    if (widget.isTakePhotoAvailable) {
      widgets.add(IconButton(
        icon: Icon(Icons.photo_camera),
        onPressed: () => _pickImage(ImagePickerSource.camera),
      ));
    }

    List<bool> toggleButtons = List.generate(widgets.length, (index) => false);

    return Container(
      child: ToggleButtons(
        children: widgets,
        isSelected: toggleButtons,
        onPressed: (index) {
          setState(() {
            toggleButtons[index] = true;
          });
        },
      ),
    );
  }
}
