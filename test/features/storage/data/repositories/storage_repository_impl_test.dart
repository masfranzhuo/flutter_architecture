import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/features/storage/data/data_sources/firebase_storage_data_source.dart';
import 'package:flutter_architecture/features/storage/data/repositories/storage_repository_impl.dart';
import 'package:flutter_architecture/features/storage/domain/entities/file_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseStorageDataSource extends Mock
    implements FirebaseStorageDataSource {}

void main() {
  StorageRepositoryImpl repository;
  MockFirebaseStorageDataSource mockFirebaseStorageDataSource;

  setUp(() {
    mockFirebaseStorageDataSource = MockFirebaseStorageDataSource();
    repository = StorageRepositoryImpl(
      firebaseStorageDataSource: mockFirebaseStorageDataSource,
    );
  });

  final urlTest = 'https://fakeimage.com/image.jpg';

  group('uploadFile', () {
    final filePathTestTest = '/data/image.jpg';
    final fileTypeTestTest = FileType.image;

    test('should upload file and return url', () async {
      when(mockFirebaseStorageDataSource.storageUploadTask(
        filePath: anyNamed('filePath'),
        fileType: anyNamed('fileType'),
      )).thenAnswer((_) async => urlTest);

      final result = await repository.uploadFile(
        filePath: filePathTestTest,
        fileType: fileTypeTestTest,
      );

      verify(mockFirebaseStorageDataSource.storageUploadTask(
        filePath: anyNamed('filePath'),
        fileType: anyNamed('fileType'),
      ));
      expect(result, Right(urlTest));
    });
  });

  group('deleteFile', () {
    test('should delete file and return url', () async {
      when(mockFirebaseStorageDataSource.deleteStorageFile(
        url: anyNamed('url'),
      )).thenAnswer((_) async => urlTest);

      final result = await repository.deleteFile(url: urlTest);

      verify(mockFirebaseStorageDataSource.deleteStorageFile(
        url: anyNamed('url'),
      ));
      expect(result, Right(urlTest));
    });
  });
}
