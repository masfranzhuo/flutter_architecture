import 'dart:io';

import 'package:flutter_architecture/features/storage/domain/entities/file_type.dart';
import 'package:flutter_architecture/features/storage/presentation/blocs/storage_bloc/storage_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// ignore: must_be_immutable
class MockStorageEvent extends Mock implements StorageEvent {}

class MockFile extends Mock implements File {}

void main() {
  group('StorageEvent', () {
    test('props are null', () {
      final mockEvent = MockStorageEvent();
      expect(mockEvent.props, null);
    });
  });

  group('UploadImageEvent', () {
    test('props are [file, fileType]', () {
      final mockFile = MockFile();
      final fileTypeTest = FileType.image;
      expect(
        UploadImageEvent(
          file: mockFile,
          fileType: fileTypeTest,
        ).props,
        [mockFile, fileTypeTest],
      );
    });
  });

  group('DeleteImageEvent', () {
    test('props are [url]', () {
      final urlTest = 'https://fakeimage.com/image.jpg';
      expect(DeleteImageEvent(url: urlTest).props, [urlTest]);
    });
  });
}
