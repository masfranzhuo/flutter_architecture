import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';

abstract class FirebaseStorageDataSource {
  Future<String> storageUploadTask({
    @required File file,
    @required String fileType,
  });

  Future<String> deleteStorageFile({@required String url});
}

class FirebaseStorageDataSourceImpl extends FirebaseStorageDataSource {
  final FirebaseStorage firebaseStorageInstance;

  FirebaseStorageDataSourceImpl({@required this.firebaseStorageInstance});

  @override
  Future<String> storageUploadTask({
    @required File file,
    @required String fileType,
  }) async {
    StorageReference storageReference =
        firebaseStorageInstance.ref().child('$fileType${file.path}');
    StorageUploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.onComplete;
    return storageReference.getDownloadURL().then((fileUrl) {
      return fileUrl;
    });
  }

  @override
  Future<String> deleteStorageFile({@required String url}) {
    // TODO: implement deleteStorageFile
    throw UnimplementedError();
  }
}
