import 'package:meta/meta.dart';

abstract class FirebaseStorageDataSource {
  Future<String> storageUploadTask({
    @required String filePath,
    @required String fileType,
  });

  Future<String> deleteStorageFile({@required String url});
}
