import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/exceptions/app_exception.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/features/storage/data/data_sources/firebase_storage_data_source.dart';
import 'package:flutter_architecture/features/storage/data/repositories/storage_repository_impl.dart';
import 'package:flutter_architecture/features/storage/domain/entities/file_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseStorageDataSource extends Mock
    implements FirebaseStorageDataSource {}

// ignore: must_be_immutable
class MockAppException extends Mock implements AppException {}

// ignore: must_be_immutable
class MockFailure extends Mock implements Failure {}

class MockFile extends Mock implements File {}

void main() {
  StorageRepositoryImpl repository;
  MockFirebaseStorageDataSource mockFirebaseStorageDataSource;

  MockAppException mockAppException;
  MockFailure mockFailure;

  setUp(() {
    mockFirebaseStorageDataSource = MockFirebaseStorageDataSource();
    repository = StorageRepositoryImpl(
      firebaseStorageDataSource: mockFirebaseStorageDataSource,
    );

    mockAppException = MockAppException();
    mockFailure = MockFailure();
  });

  final urlTest = 'https://fakeimage.com/image.jpg';

  group('uploadFile', () {
    final mockFile = MockFile();
    final fileTypeTest = FileType.image;

    test('should upload file and return url', () async {
      when(mockFirebaseStorageDataSource.storageUploadTask(
        file: anyNamed('file'),
        fileType: anyNamed('fileType'),
      )).thenAnswer((_) async => urlTest);

      final result = await repository.uploadFile(
        file: mockFile,
        fileType: fileTypeTest,
      );

      verify(mockFirebaseStorageDataSource.storageUploadTask(
        file: anyNamed('file'),
        fileType: anyNamed('fileType'),
      ));
      expect(result, Right(urlTest));
    });

    test('should return UnexpectedFailure', () async {
      when(mockFirebaseStorageDataSource.storageUploadTask(
        file: anyNamed('file'),
        fileType: anyNamed('fileType'),
      )).thenThrow(UnexpectedException());

      final result = await repository.uploadFile(
        file: mockFile,
        fileType: fileTypeTest,
      );

      expect((result as Left).value, isA<UnexpectedFailure>());
    });

    test(
      'should call toFailure if exception is AppException',
      () async {
        when(mockAppException.toFailure()).thenReturn(mockFailure);
        when(mockFirebaseStorageDataSource.storageUploadTask(
          file: anyNamed('file'),
          fileType: anyNamed('fileType'),
        )).thenThrow(mockAppException);

        final result = await repository.uploadFile(
          file: mockFile,
          fileType: fileTypeTest,
        );

        expect((result as Left).value, mockFailure);
        expect((result as Left).value, isA<Failure>());
      },
    );
  });

  group('deleteFile', () {
    test('should delete file and return url', () async {
      when(mockFirebaseStorageDataSource.deleteStorageFile(
        url: anyNamed('url'),
      )).thenAnswer((_) async => true);

      final result = await repository.deleteFile(url: urlTest);

      verify(mockFirebaseStorageDataSource.deleteStorageFile(
        url: anyNamed('url'),
      ));
      expect(result, Right(true));
    });

    test('should return UnexpectedFailure', () async {
      when(mockFirebaseStorageDataSource.deleteStorageFile(
        url: anyNamed('url'),
      )).thenThrow(UnexpectedException());

      final result = await repository.deleteFile(url: urlTest);

      expect((result as Left).value, isA<UnexpectedFailure>());
    });

    test(
      'should call toFailure if exception is AppException',
      () async {
        when(mockAppException.toFailure()).thenReturn(mockFailure);
        when(mockFirebaseStorageDataSource.deleteStorageFile(
          url: anyNamed('url'),
        )).thenThrow(mockAppException);

        final result = await repository.deleteFile(url: urlTest);

        expect((result as Left).value, mockFailure);
        expect((result as Left).value, isA<Failure>());
      },
    );
  });
}
