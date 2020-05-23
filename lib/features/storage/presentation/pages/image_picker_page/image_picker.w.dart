part of 'image_picker_page.dart';

class _$ImagePicker extends StatefulWidget {
  final bool isPickImageAvailable;
  final bool isTakePhotoAvailable;
  final bool isCropAvailable;

  const _$ImagePicker({
    Key key,
    this.isPickImageAvailable,
    this.isTakePhotoAvailable,
    this.isCropAvailable,
  }) : super(key: key);

  @override
  __$ImagePickerState createState() => __$ImagePickerState();
}

class __$ImagePickerState extends State<_$ImagePicker> {
  File _file;

  // TODO: change this to CustomImagePicker
  void _pickImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    if (widget.isCropAvailable) {
      image = await ImageCropper.cropImage(sourcePath: image.path);
    }

    setState(() {
      _file = image;
    });
  }

  void _takePhoto() async {
    File photo = await ImagePicker.pickImage(source: ImageSource.camera);

    if (photo == null) return;

    if (widget.isCropAvailable) {
      photo = await ImageCropper.cropImage(sourcePath: photo.path);
    }

    setState(() {
      _file = photo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildImage(context),
          _buildButton(context),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: _file != null
          ? FadeInImage(
              image: FileImage(_file),
              placeholder: NetworkImage(
                'https://via.placeholder.com/512x512.png?text=Image preview',
              ),
            )
          : Image.network(
              'https://via.placeholder.com/512x512.png?text=Image preview',
            ),
    );
  }

  Widget _buildButton(BuildContext context) {
    List<Widget> widgets = [];
    Widget _doneWidget = SizedBox();

    if (widget.isPickImageAvailable) {
      widgets.add(CustomButton(
        child: Icon(Icons.image),
        onPressed: () => _pickImage(),
      ));
    }

    if (widget.isTakePhotoAvailable) {
      widgets.add(CustomButton(
        child: Icon(Icons.photo_camera),
        onPressed: () => _takePhoto(),
      ));
    }

    if (_file != null) {
      _doneWidget = Container(
        margin: const EdgeInsets.fromLTRB(32, 0, 32, 16),
        child: CustomButton(
          child: Icon(Icons.check),
          onPressed: () {
            Navigator.pop(context, _file);
          },
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(32, 0, 32, 32),
      child: Column(
        children: <Widget>[
          _doneWidget,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widgets,
          ),
        ],
      ),
    );
  }
}
