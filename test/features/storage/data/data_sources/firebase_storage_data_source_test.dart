import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_architecture/features/storage/data/data_sources/firebase_storage_data_source.dart';
import 'package:flutter_architecture/features/storage/domain/entities/file_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseStorage extends Mock implements FirebaseStorage {}

class MockStorageReference extends Mock implements StorageReference {}

class MockStorageUploadTask extends Mock implements StorageUploadTask {}

class MockFile extends Mock implements File {}

void main() {
  FirebaseStorageDataSourceImpl dataSource;
  MockFirebaseStorage mockFirebaseStorage;

  setUp(() {
    mockFirebaseStorage = MockFirebaseStorage();
    dataSource = FirebaseStorageDataSourceImpl(
      firebaseStorageInstance: mockFirebaseStorage,
    );
  });

  final urlTest = 'https://fakeimage.com/image.jpg';

  group('storageUploadTask', () {
    MockStorageReference mockStorageReference = MockStorageReference();
    MockStorageUploadTask mockStorageUploadTask = MockStorageUploadTask();

    final mockFile = MockFile();
    final filePathTest = '/data/image.jpg';
    final fileTypeTest = FileType.image;

    test('should return uploaded file url', () async {
      when(mockFirebaseStorage.ref().child(any))
          .thenAnswer((_) => mockStorageReference);
      when(mockStorageReference.putFile(any))
          .thenAnswer((_) => mockStorageUploadTask);
      when(mockStorageUploadTask.onComplete);

      final result = await dataSource.storageUploadTask(
        file: mockFile,
        fileType: fileTypeTest,
      );

      verifyInOrder([
        mockFirebaseStorage.ref().child('$fileTypeTest$filePathTest'),
        mockStorageReference.putFile(mockFile),
        mockStorageUploadTask.onComplete,
      ]);
      expect(result, urlTest);
    });
  });

  group('deleteStorageFile', () {});
}
