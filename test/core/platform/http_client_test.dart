import 'package:dio/dio.dart';
import 'package:flutter_architecture/core/error/exceptions/app_exception.dart';
import 'package:flutter_architecture/core/platform/http_client.dart';
import 'package:flutter_architecture/features/account/data/data_sources/firebase_auth_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDio extends Mock implements Dio {}

class MockInterceptors extends Mock implements Interceptors {}

class MockFirebaseAuthDataSource extends Mock
    implements FirebaseAuthDataSource {}

class MockResponse extends Mock implements Response {}

void main() {
  HttpClient httpClient;
  MockDio mockDio;
  MockInterceptors mockInterceptors;
  MockFirebaseAuthDataSource mockFirebaseAuthDataSource;

  MockResponse mockResponse;

  setUp(() {
    mockDio = MockDio();
    mockInterceptors = MockInterceptors();
    mockFirebaseAuthDataSource = MockFirebaseAuthDataSource();

    mockResponse = MockResponse();
  });

  final idTokenNullTest = null;
  final idTokenTest = 'idToken';

  HttpClient setUpHttpClient({
    bool isCached = false,
    bool isLogged = false,
  }) {
    return httpClient = HttpClient(
      dioHttpClient: mockDio,
      firebaseAuthDataSource: mockFirebaseAuthDataSource,
      isCached: isCached,
      isLogged: isLogged,
    );
  }

  setUpHttpClientWithInterceptor() {
    httpClient = setUpHttpClient(isCached: true, isLogged: true);
    when(mockDio.interceptors).thenReturn(mockInterceptors);
    when(mockInterceptors.add(any)).thenReturn(mockDio);
    when(mockFirebaseAuthDataSource.getCurrentUserIdToken()).thenAnswer(
      (_) async => idTokenTest,
    );
  }

  setUpGetCurrentUserIdTokenSuccessfully() {
    httpClient = setUpHttpClient();
    when(mockFirebaseAuthDataSource.getCurrentUserIdToken()).thenAnswer(
      (_) async => idTokenTest,
    );
  }

  setUpGetCurrentUserIdTokenFailed() {
    httpClient = setUpHttpClient();
    when(mockFirebaseAuthDataSource.getCurrentUserIdToken()).thenAnswer(
      (_) async => idTokenNullTest,
    );
  }

  group('Dio', () {
    test('should return existing dio', () async {
      httpClient = setUpHttpClient();

      expect(httpClient.dio, mockDio);
    });

    test('should set isCached, isLogged', () async {
      httpClient = setUpHttpClient(isCached: true, isLogged: true);
      httpClient.cache = false;
      httpClient.logger = false;

      expect(httpClient.isCached, false);
      expect(httpClient.isLogged, false);
    });
  });

  group('postFormData', () {
    test('should call interceptors', () async {
      setUpHttpClientWithInterceptor();

      await httpClient.postFormData(
        endPoint: EndPoint.auth,
        formData: FormData(),
      );

      verify(mockDio.interceptors);
      verify(mockInterceptors.add(any));
      verify(mockFirebaseAuthDataSource.getCurrentUserIdToken());
    });

    test('should call getIdToken', () async {
      setUpGetCurrentUserIdTokenSuccessfully();

      await httpClient.postFormData(
        endPoint: EndPoint.auth,
        formData: FormData(),
      );

      verify(mockFirebaseAuthDataSource.getCurrentUserIdToken());
    });

    test(
      'should call post of dio with correct endpoint along with data and options',
      () async {
        setUpGetCurrentUserIdTokenSuccessfully();
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

    test(
      'should return dio error exception response',
      () async {
        setUpGetCurrentUserIdTokenSuccessfully();
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenThrow(DioError(response: mockResponse));

        final result = await httpClient.postFormData(
          endPoint: EndPoint.auth,
          formData: FormData(),
        );

        expect(result, mockResponse);
      },
    );

    test('should throw InvalidIdTokenException', () async {
      setUpGetCurrentUserIdTokenFailed();

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

  group('postFirebaseData', () {
    final idTest = 'user_uid';

    test('should call getIdToken', () async {
      setUpGetCurrentUserIdTokenSuccessfully();

      await httpClient.postFirebaseData(
        endPoint:
            '${EndPoint.users}/$idTest.json?${EndPoint.auth}=$idTokenTest',
        formData: {},
      );

      verify(mockFirebaseAuthDataSource.getCurrentUserIdToken());
    });

    test(
      'should call post of dio with correct endpoint along with data and options',
      () async {
        setUpGetCurrentUserIdTokenSuccessfully();
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenAnswer(
          (_) async => Response(statusCode: 201),
        );

        await httpClient.postFirebaseData(
          endPoint:
              '${EndPoint.users}/$idTest.json?${EndPoint.auth}=$idTokenTest',
          formData: {},
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

    test(
      'should return dio error exception response',
      () async {
        setUpGetCurrentUserIdTokenSuccessfully();
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenThrow(DioError(response: mockResponse));

        final result = await httpClient.postFirebaseData(
          endPoint:
              '${EndPoint.users}/$idTest.json?${EndPoint.auth}=$idTokenTest',
          formData: {},
        );

        expect(result, mockResponse);
      },
    );

    test('should throw InvalidIdTokenException', () async {
      setUpGetCurrentUserIdTokenFailed();

      expect(
        () async => await httpClient.postFirebaseData(
          endPoint:
              '${EndPoint.users}/$idTest.json?${EndPoint.auth}=$idTokenNullTest',
          formData: {},
        ),
        throwsA(isA<InvalidIdTokenException>()),
      );
      verify(mockFirebaseAuthDataSource.getCurrentUserIdToken());
    });
  });

  group('patchFirebaseData', () {
    final idTest = 'user_uid';

    test('should call getIdToken', () async {
      setUpGetCurrentUserIdTokenSuccessfully();

      await httpClient.patchFirebaseData(
        endPoint:
            '${EndPoint.users}/$idTest.json?${EndPoint.auth}=$idTokenTest',
        formData: {},
      );

      verify(mockFirebaseAuthDataSource.getCurrentUserIdToken());
    });

    test(
      'should call patch of dio with correct endpoint along with data and options',
      () async {
        setUpGetCurrentUserIdTokenSuccessfully();
        when(mockDio.patch(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenAnswer(
          (_) async => Response(statusCode: 201),
        );

        await httpClient.patchFirebaseData(
          endPoint:
              '${EndPoint.users}/$idTest.json?${EndPoint.auth}=$idTokenTest',
          formData: {},
        );

        verify(mockFirebaseAuthDataSource.getCurrentUserIdToken());
        verify(
          mockDio.patch(
            any,
            data: anyNamed('data'),
            options: anyNamed('options'),
          ),
        );
      },
    );

    test(
      'should return dio error exception response',
      () async {
        setUpGetCurrentUserIdTokenSuccessfully();
        when(mockDio.patch(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenThrow(DioError(response: mockResponse));

        final result = await httpClient.patchFirebaseData(
          endPoint:
              '${EndPoint.users}/$idTest.json?${EndPoint.auth}=$idTokenTest',
          formData: {},
        );

        expect(result, mockResponse);
      },
    );

    test('should throw InvalidIdTokenException', () async {
      setUpGetCurrentUserIdTokenFailed();

      expect(
        () async => await httpClient.patchFirebaseData(
          endPoint:
              '${EndPoint.users}/$idTest.json?${EndPoint.auth}=$idTokenNullTest',
          formData: {},
        ),
        throwsA(isA<InvalidIdTokenException>()),
      );
      verify(mockFirebaseAuthDataSource.getCurrentUserIdToken());
    });
  });

  group('getFirebaseData', () {
    final idTest = 'user_uid';

    test('should call getIdToken', () async {
      setUpGetCurrentUserIdTokenSuccessfully();

      await httpClient.getFirebaseData(
        endPoint:
            '${EndPoint.users}/$idTest.json?${EndPoint.auth}=$idTokenTest',
      );

      verify(mockFirebaseAuthDataSource.getCurrentUserIdToken());
    });

    test(
      'should call get of dio with correct endpoint along with data and options',
      () async {
        setUpGetCurrentUserIdTokenSuccessfully();
        when(mockDio.get(
          any,
          options: anyNamed('options'),
        )).thenAnswer(
          (_) async => Response(statusCode: 201),
        );

        await httpClient.getFirebaseData(
          endPoint:
              '${EndPoint.users}/$idTest.json?${EndPoint.auth}=$idTokenTest',
        );

        verify(mockFirebaseAuthDataSource.getCurrentUserIdToken());
        verify(
          mockDio.get(
            any,
            options: anyNamed('options'),
          ),
        );
      },
    );

    test(
      'should return dio error exception response',
      () async {
        setUpGetCurrentUserIdTokenSuccessfully();
        when(mockDio.get(
          any,
          options: anyNamed('options'),
        )).thenThrow(DioError(response: mockResponse));

        final result = await httpClient.getFirebaseData(
          endPoint:
              '${EndPoint.users}/$idTest.json?${EndPoint.auth}=$idTokenTest',
        );

        expect(result, mockResponse);
      },
    );

    test('should throw InvalidIdTokenException', () async {
      setUpGetCurrentUserIdTokenFailed();

      expect(
        () async => await httpClient.getFirebaseData(
          endPoint:
              '${EndPoint.users}/$idTest.json?${EndPoint.auth}=$idTokenNullTest',
        ),
        throwsA(isA<InvalidIdTokenException>()),
      );
      verify(mockFirebaseAuthDataSource.getCurrentUserIdToken());
    });
  });
}
