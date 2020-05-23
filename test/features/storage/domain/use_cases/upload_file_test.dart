import 'dart:io';

import 'package:flutter_architecture/features/storage/domain/entities/file_type.dart';
import 'package:flutter_architecture/features/storage/domain/repositories/storage_repository.dart';
import 'package:flutter_architecture/features/storage/domain/use_cases/upload_file.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockStorageRepository extends Mock implements StorageRepository {}

class MockFile extends Mock implements File {}

void main() {
  UploadFile uploadFile;
  MockStorageRepository mockStorageRepository;

  setUp(() {
    mockStorageRepository = MockStorageRepository();
    uploadFile = UploadFile(repository: mockStorageRepository);
  });

  test('should call uploadFile in repository', () async {
    final mockFile = MockFile();
    final fileTypeTest = FileType.image;
    await uploadFile(Params(file: mockFile, fileType: fileTypeTest));
    verify(mockStorageRepository.uploadFile(
      file: mockFile,
      fileType: fileTypeTest,
    ));
  });
}
