import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_architecture/features/storage/data/data_sources/firebase_storage_data_source.dart';
import 'package:flutter_architecture/features/storage/domain/entities/file_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseStorage extends Mock implements FirebaseStorage {}

class MockStorageReference extends Mock implements StorageReference {}

class MockStorageUploadTask extends Mock implements StorageUploadTask {}

class MockStorageTaskSnapshot extends Mock implements StorageTaskSnapshot {}

void main() {
  FirebaseStorageDataSourceImpl dataSource;
  MockFirebaseStorage mockFirebaseStorage;

  MockStorageReference mockStorageReference;

  setUp(() {
    mockFirebaseStorage = MockFirebaseStorage();
    dataSource = FirebaseStorageDataSourceImpl(
      firebaseStorageInstance: mockFirebaseStorage,
    );

    mockStorageReference = MockStorageReference();
  });

  final urlTest = 'https://fakeimage.com/image.jpg';

  // TODO: test error case
  group('storageUploadTask', () {
    MockStorageUploadTask mockStorageUploadTask = MockStorageUploadTask();
    MockStorageTaskSnapshot mockStorageTaskSnapshot = MockStorageTaskSnapshot();

    final fileTypeTest = FileType.image;
    final fileTest = File('/data/$urlTest');

    test('should return uploaded file url', () async {
      when(mockFirebaseStorage.ref()).thenAnswer((_) => mockStorageReference);
      when(mockStorageReference.child(any)).thenReturn(mockStorageReference);
      when(mockStorageReference.putFile(any))
          .thenAnswer((_) => mockStorageUploadTask);
      when(mockStorageUploadTask.onComplete)
          .thenAnswer((_) async => mockStorageTaskSnapshot);
      when(mockStorageReference.getDownloadURL())
          .thenAnswer((_) async => urlTest);

      final result = await dataSource.storageUploadTask(
        file: fileTest,
        fileType: fileTypeTest,
      );

      verifyInOrder([
        mockFirebaseStorage.ref(),
        mockStorageReference.child(any),
        mockStorageReference.putFile(any),
        mockStorageUploadTask.onComplete,
        mockStorageReference.getDownloadURL(),
      ]);
      expect(result, urlTest);
    });
  });

  group('deleteStorageFile', () {
    test('should delete file by its url', () async {
      when(mockFirebaseStorage.getReferenceFromUrl(any))
          .thenAnswer((_) async => mockStorageReference);
      when(mockStorageReference.delete());

      await dataSource.deleteStorageFile(url: urlTest);

      verifyInOrder([
        mockFirebaseStorage.getReferenceFromUrl(any),
        mockStorageReference.delete(),
      ]);
    });
  });
}
