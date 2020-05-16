import 'package:flutter_architecture/features/storage/domain/repositories/storage_repository.dart';
import 'package:flutter_architecture/features/storage/domain/use_cases/upload_file.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockStorageRepository extends Mock implements StorageRepository {}

void main() {
  UploadFile uploadFile;
  MockStorageRepository mockStorageRepository;

  setUp(() {
    mockStorageRepository = MockStorageRepository();
    uploadFile = UploadFile(repository: mockStorageRepository);
  });

  test('should call uploadFile in repository', () async {
    final filePathTest = '/data/image.jpg';
    final fileTypeTest = 'IMAGE';
    await uploadFile(Params(filePath: filePathTest, fileType: fileTypeTest));
    verify(mockStorageRepository.uploadFile(
      filePath: filePathTest,
      fileType: fileTypeTest,
    ));
  });
}
