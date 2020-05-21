part of 'image_picker_page.dart';

class _$ImagePicker extends StatefulWidget {
  final bool isPickImageAvailable;
  final bool isTakePhotoAvailable;

  const _$ImagePicker({
    Key key,
    this.isPickImageAvailable,
    this.isTakePhotoAvailable,
  }) : super(key: key);

  @override
  __$ImagePickerState createState() => __$ImagePickerState();
}

class __$ImagePickerState extends State<_$ImagePicker> {
  File file;

  void _pickImage() async {
    // TODO: pick image
    print('pickImage');
  }

  void _takePhoto() async {
    // TODO: take photo
    print('takePhoto');
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
      child: FadeInImage(
        image: NetworkImage(
          'https://via.placeholder.com/512x512.png?text=Image preview',
        ), //FileImage(file),
        placeholder: NetworkImage(
          'https://via.placeholder.com/512x512.png?text=Image preview',
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    List<Widget> widgets = [];

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

    return Container(
      margin: const EdgeInsets.fromLTRB(32, 32, 32, 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widgets,
      ),
    );
  }
}
