import 'package:dio/dio.dart';
import 'package:flutter_architecture/core/error/exception.dart';
import 'package:flutter_architecture/core/platform/http_client.dart';
import 'package:flutter_architecture/features/account/data/data_sources/firebase_auth_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDio extends Mock implements Dio {}

class MockFirebaseAuthDataSource extends Mock
    implements FirebaseAuthDataSource {}

void main() {
  HttpClient httpClient;
  MockDio mockDio;
  MockFirebaseAuthDataSource mockFirebaseAuthDataSource;

  setUp(() {
    mockDio = MockDio();
    mockFirebaseAuthDataSource = MockFirebaseAuthDataSource();
    httpClient = HttpClient(
      dioHttpClient: mockDio,
      firebaseAuthDataSource: mockFirebaseAuthDataSource,
    );
  });

  group('postFormData', () {
    final idTokenTest = 'idToken';

    test('should call getIdToken', () async {
      when(mockFirebaseAuthDataSource.getCurrentUserIdToken()).thenAnswer(
        (_) async => idTokenTest,
      );

      await httpClient.postFormData(
        endPoint: EndPoint.auth,
        formData: FormData(),
      );

      verify(mockFirebaseAuthDataSource.getCurrentUserIdToken());
    });

    test(
      'should call post of dio with correct endpoint along with data and options',
      () async {
        when(mockFirebaseAuthDataSource.getCurrentUserIdToken()).thenAnswer(
          (_) async => idTokenTest,
        );
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenAnswer(
          (_) async => Response(statusCode: 201),
        );

        await httpClient.postFormData(
          endPoint: EndPoint.auth,
          formData: FormData(),
        );

        verify(mockFirebaseAuthDataSource.getCurrentUserIdToken());
        verify(
          mockDio.post(
            any,
            data: anyNamed('data'),
            options: anyNamed('options'),
          ),
        );
      },
    );

    test('should throw InvalidIdTokenException', () async {
      when(mockFirebaseAuthDataSource.getCurrentUserIdToken()).thenAnswer(
        (_) async => null,
      );

      expect(
        () async => await httpClient.postFormData(
          endPoint: EndPoint.auth,
          formData: FormData(),
        ),
        throwsA(isA<InvalidIdTokenException>()),
      );
      verify(mockFirebaseAuthDataSource.getCurrentUserIdToken());
    });
  });
}
