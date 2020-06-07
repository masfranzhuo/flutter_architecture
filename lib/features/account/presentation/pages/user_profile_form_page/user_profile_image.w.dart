part of 'user_profile_form_page.dart';

class _$UserProfileImage extends StatefulWidget {
  final String imageUrl;

  const _$UserProfileImage({Key key, @required this.imageUrl})
      : super(key: key);

  @override
  __$UserProfileImageState createState() => __$UserProfileImageState();
}

class __$UserProfileImageState extends State<_$UserProfileImage> {
  String _imageUrl;

  @override
  void initState() {
    _imageUrl = widget.imageUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 4;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32, horizontal: width),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width),
        child: CustomImagePicker(
          imageUrl: _imageUrl,
          defaultImage: Icon(Icons.person, size: width),
          isCropAvailable: true,
          onPicked: (value) {
            BlocProvider.of<StorageBloc>(context).add(UploadImageEvent(
              file: value,
              fileType: FileType.image,
            ));
          },
        ),
      ),
    );
  }
}
