import 'dart:io';

import 'package:flutter_architecture/features/storage/domain/entities/file_type.dart';
import 'package:flutter_architecture/features/storage/presentation/blocs/storage_bloc/storage_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFile extends Mock implements File {}

void main() {
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
