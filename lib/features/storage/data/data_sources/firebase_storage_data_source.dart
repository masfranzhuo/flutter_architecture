import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';

abstract class FirebaseStorageDataSource {
  Future<String> storageUploadTask({
    @required File file,
    @required String fileType,
  });

  /// Convert file url from Firebase Storage into StorageReference,
  /// then we could use this to delete the file in Firebase Storage.
  Future<void> deleteStorageFile({@required String url, String fileType});
}

class FirebaseStorageDataSourceImpl extends FirebaseStorageDataSource {
  final FirebaseStorage firebaseStorageInstance;

  FirebaseStorageDataSourceImpl({@required this.firebaseStorageInstance});

  @override
  Future<String> storageUploadTask({
    @required File file,
    @required String fileType,
  }) async {
    StorageReference storageReference = firebaseStorageInstance.ref();
    storageReference.child('$fileType${file.path}');

    StorageUploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.onComplete;

    String fileUrl = await storageReference.getDownloadURL();
    return fileUrl;
  }

  @override
  Future<void> deleteStorageFile({
    @required String url,
    String fileType,
  }) async {
    StorageReference storageReference =
        await firebaseStorageInstance.getReferenceFromUrl(url);

    return await storageReference.delete();
  }
}
