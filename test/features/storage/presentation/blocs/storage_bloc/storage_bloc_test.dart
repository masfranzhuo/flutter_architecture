import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/features/storage/domain/entities/file_type.dart';
import 'package:flutter_architecture/features/storage/domain/use_cases/delete_file.dart';
import 'package:flutter_architecture/features/storage/domain/use_cases/upload_file.dart';
import 'package:flutter_architecture/features/storage/presentation/blocs/storage_bloc/storage_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUploadFile extends Mock implements UploadFile {}

class MockDeleteFile extends Mock implements DeleteFile {}

class MockFile extends Mock implements File {}

void main() {
  StorageBloc bloc;
  MockUploadFile mockUploadFile;
  MockDeleteFile mockDeleteFile;

  setUp(() {
    mockUploadFile = MockUploadFile();
    mockDeleteFile = MockDeleteFile();
    bloc = StorageBloc(
      uploadFile: mockUploadFile,
      deleteFile: mockDeleteFile,
    );
  });

  tearDown(() {
    bloc?.close();
  });

  blocTest(
    'initial state should be initial',
    build: () async => bloc,
    skip: 0,
    expect: [StorageInitialState()],
  );

  group('UploadImageEvent', () {
    final mockFile = MockFile();
    final fileTypeTest = FileType.image;
    final urlTest = 'https://fakeimage.com/image.jpg';

    blocTest(
      'should emit [StorageLoadingState, StorageUploadedState] when upload is successful',
      build: () async {
        when(mockUploadFile(any)).thenAnswer((_) async => Right(urlTest));
        return bloc;
      },
      act: (bloc) => bloc.add(UploadImageEvent(
        file: mockFile,
        fileType: fileTypeTest,
      )),
      expect: [
        StorageLoadingState(),
        StorageUploadedState(url: urlTest),
      ],
    );

    blocTest(
      'should emit [StorageLoadingState, StorageErrorState] when upload is failed',
      build: () async {
        when(mockUploadFile(any)).thenAnswer(
          (_) async => Left(InvalidIdTokenFailure()),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(UploadImageEvent(
        file: mockFile,
        fileType: fileTypeTest,
      )),
      expect: [
        StorageLoadingState(),
        StorageErrorState(failure: InvalidIdTokenFailure()),
      ],
    );
  });

  group('DeleteImageEvent', () {
    final urlTest = 'https://fakeimage.com/image.jpg';

    blocTest(
      'should emit [StorageLoadingState, StorageDeletedState] when delete is successful',
      build: () async {
        when(mockDeleteFile(any)).thenAnswer((_) async => Right(true));
        return bloc;
      },
      act: (bloc) => bloc.add(DeleteImageEvent(url: urlTest)),
      expect: [
        StorageLoadingState(),
        StorageDeletedState(),
      ],
    );

    blocTest(
      'should emit [StorageLoadingState, StorageErrorState] when delete is failed',
      build: () async {
        when(mockDeleteFile(any)).thenAnswer(
          (_) async => Left(InvalidIdTokenFailure()),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(DeleteImageEvent(url: urlTest)),
      expect: [
        StorageLoadingState(),
        StorageErrorState(failure: InvalidIdTokenFailure()),
      ],
    );
  });
}
