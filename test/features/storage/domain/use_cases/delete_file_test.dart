import 'package:flutter_architecture/features/storage/domain/repositories/storage_repository.dart';
import 'package:flutter_architecture/features/storage/domain/use_cases/delete_file.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockStorageRepository extends Mock implements StorageRepository {}

void main() {
  DeleteFile deleteFile;
  MockStorageRepository mockStorageRepository;

  setUp(() {
    mockStorageRepository = MockStorageRepository();
    deleteFile = DeleteFile(repository: mockStorageRepository);
  });

  final urlTest = 'https://fakeimage.com/image.jpg';

  test('should call deleteFile in repository', () async {
    await deleteFile(Params(url: urlTest));
    verify(mockStorageRepository.deleteFile(url: urlTest));
  });

  group('Params', () {
    test('props are [url]', () {
      expect(Params(url: urlTest).props, [urlTest]);
    });
  });
}
