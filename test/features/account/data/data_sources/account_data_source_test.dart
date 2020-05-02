import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_architecture/core/error/exception.dart';
import 'package:flutter_architecture/core/platform/http_client.dart';
import 'package:flutter_architecture/features/account/data/data_sources/account_data_source.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixtures_reader.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  AccountDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  Map<String, dynamic> customerFixture, staffFixture;
  Customer customer;
  Staff staff;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = AccountDataSourceImpl(client: mockHttpClient);

    customerFixture =
        json.decode(fixture('fixtures/customers/minimum_valid.json'));
    customer = Customer.fromJson(Map<String, dynamic>.from(customerFixture));

    staffFixture = Map<String, dynamic>.from(
      json.decode(fixture('fixtures/staffs/minimum_valid.json')),
    );
    staff = Staff.fromJson(staffFixture);
  });

  final idTest = 'fake_id';
  final deviceTokenTest = 'mockdevicetoken';
  final nameTest = 'John Doe';
  final emailTest = 'john@doe.com';

  group('setDeviceToken', () {
    setUpPostSuccessfully() {
      when(mockHttpClient.postFirebaseData(
        endPoint: anyNamed('endPoint'),
        formData: anyNamed('formData'),
      )).thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          data: staffFixture,
          statusCode: 200,
        ),
      );
    }

    setUpPatchSuccessfully() {
      when(mockHttpClient.patchFirebaseData(
        endPoint: anyNamed('endPoint'),
        formData: anyNamed('formData'),
      )).thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          data: customerFixture,
          statusCode: 200,
        ),
      );
    }

    setUpResponseStatusCode(int statusCode) {
      when(mockHttpClient.patchFirebaseData(
        endPoint: anyNamed('endPoint'),
        formData: anyNamed('formData'),
      )).thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          statusCode: statusCode,
        ),
      );
    }

    test('should call postFirebaseData of HttpClient when register', () async {
      setUpPostSuccessfully();

      await dataSource.setUserProfile(
        id: idTest,
        deviceToken: deviceTokenTest,
        name: nameTest,
        email: emailTest,
      );

      verify(mockHttpClient.postFirebaseData(
        endPoint: anyNamed('endPoint'),
        formData: anyNamed('formData'),
      ));
    });

    test('should call patchFirebaseData of HttpClient when login', () async {
      setUpPatchSuccessfully();

      await dataSource.setUserProfile(
        id: idTest,
        deviceToken: deviceTokenTest,
      );

      verify(mockHttpClient.patchFirebaseData(
        endPoint: anyNamed('endPoint'),
        formData: anyNamed('formData'),
      ));
    });
    test('should return Customer', () async {
      setUpPatchSuccessfully();

      final result = await dataSource.setUserProfile(
        id: idTest,
        deviceToken: deviceTokenTest,
      );

      expect(result, customer);
    });
    test('should return Staff', () async {
      setUpPostSuccessfully();

      final result = await dataSource.setUserProfile(
        id: idTest,
        deviceToken: deviceTokenTest,
        name: nameTest,
        email: emailTest,
      );

      expect(result, staff);
    });
    test('should throw InvalidIdTokenException', () async {
      setUpResponseStatusCode(401);

      expect(
        () async => await dataSource.setUserProfile(
          id: idTest,
          deviceToken: deviceTokenTest,
        ),
        throwsA(isA<InvalidIdTokenException>()),
      );
    });
    test('should throw NotFoundException', () async {
      setUpResponseStatusCode(404);

      expect(
        () async => await dataSource.setUserProfile(
          id: idTest,
          deviceToken: deviceTokenTest,
        ),
        throwsA(isA<NotFoundException>()),
      );
    });
    test('should throw BadRequestException', () async {
      setUpResponseStatusCode(400);

      expect(
        () async => await dataSource.setUserProfile(
          id: idTest,
          deviceToken: deviceTokenTest,
        ),
        throwsA(isA<BadRequestException>()),
      );
    });
    test('should throw InternalServerErrorException', () async {
      setUpResponseStatusCode(500);

      expect(
        () async => await dataSource.setUserProfile(
          id: idTest,
          deviceToken: deviceTokenTest,
        ),
        throwsA(isA<InternalServerErrorException>()),
      );
    });
    test('should throw ServiceUnavailableException', () async {
      setUpResponseStatusCode(503);

      expect(
        () async => await dataSource.setUserProfile(
          id: idTest,
          deviceToken: deviceTokenTest,
        ),
        throwsA(isA<ServiceUnavailableException>()),
      );
    });
    test('should throw PreconditionFailedException', () async {
      setUpResponseStatusCode(412);

      expect(
        () async => await dataSource.setUserProfile(
          id: idTest,
          deviceToken: deviceTokenTest,
        ),
        throwsA(isA<PreconditionFailedException>()),
      );
    });
    test('should throw UnexpectedException', () async {
      setUpResponseStatusCode(501);

      expect(
        () async => await dataSource.setUserProfile(
          id: idTest,
          deviceToken: deviceTokenTest,
        ),
        throwsA(isA<UnexpectedException>()),
      );
    });
  });
  group('removeDeviceToken', () {
    setUpResponseStatusCode(int statusCode) {
      when(mockHttpClient.patchFirebaseData(
        endPoint: anyNamed('endPoint'),
        formData: anyNamed('formData'),
      )).thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          statusCode: statusCode,
        ),
      );
    }

    test('should call patchFirebaseData', () async {
      when(mockHttpClient.patchFirebaseData(
              endPoint: anyNamed('endPoint'), formData: anyNamed('formData')))
          .thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          data: {'token': deviceTokenTest},
          statusCode: 200,
        ),
      );

      await dataSource.removeDeviceToken(
        id: idTest,
        deviceToken: deviceTokenTest,
      );

      verify(mockHttpClient.patchFirebaseData(
        endPoint: anyNamed('endPoint'),
        formData: anyNamed('formData'),
      ));
    });
    test('should return true', () async {
      when(mockHttpClient.patchFirebaseData(
              endPoint: anyNamed('endPoint'), formData: anyNamed('formData')))
          .thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          data: {'token': deviceTokenTest},
          statusCode: 200,
        ),
      );

      final result = await dataSource.removeDeviceToken(
        id: idTest,
        deviceToken: deviceTokenTest,
      );

      expect(result, true);
    });
    test('should throw InvalidIdTokenException', () async {
      setUpResponseStatusCode(401);

      expect(
        () async => await dataSource.removeDeviceToken(
          id: idTest,
          deviceToken: deviceTokenTest,
        ),
        throwsA(isA<InvalidIdTokenException>()),
      );
    });
    test('should throw NotFoundException', () async {
      setUpResponseStatusCode(404);

      expect(
        () async => await dataSource.removeDeviceToken(
          id: idTest,
          deviceToken: deviceTokenTest,
        ),
        throwsA(isA<NotFoundException>()),
      );
    });
    test('should throw BadRequestException', () async {
      setUpResponseStatusCode(400);

      expect(
        () async => await dataSource.removeDeviceToken(
          id: idTest,
          deviceToken: deviceTokenTest,
        ),
        throwsA(isA<BadRequestException>()),
      );
    });
    test('should throw InternalServerErrorException', () async {
      setUpResponseStatusCode(500);

      expect(
        () async => await dataSource.removeDeviceToken(
          id: idTest,
          deviceToken: deviceTokenTest,
        ),
        throwsA(isA<InternalServerErrorException>()),
      );
    });
    test('should throw ServiceUnavailableException', () async {
      setUpResponseStatusCode(503);

      expect(
        () async => await dataSource.removeDeviceToken(
          id: idTest,
          deviceToken: deviceTokenTest,
        ),
        throwsA(isA<ServiceUnavailableException>()),
      );
    });
    test('should throw PreconditionFailedException', () async {
      setUpResponseStatusCode(412);

      expect(
        () async => await dataSource.removeDeviceToken(
          id: idTest,
          deviceToken: deviceTokenTest,
        ),
        throwsA(isA<PreconditionFailedException>()),
      );
    });
    test('should throw UnexpectedException', () async {
      setUpResponseStatusCode(501);

      expect(
        () async => await dataSource.removeDeviceToken(
          id: idTest,
          deviceToken: deviceTokenTest,
        ),
        throwsA(isA<UnexpectedException>()),
      );
    });
  });
  group('getUserProfile', () {
    setUpResponseStatusCode(int statusCode) {
      when(mockHttpClient.getFirebaseData(
        endPoint: anyNamed('endPoint'),
      )).thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          statusCode: statusCode,
        ),
      );
    }

    test('should call getFirebaseData', () async {
      when(mockHttpClient.getFirebaseData(
        endPoint: anyNamed('endPoint'),
      )).thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          data: customerFixture,
          statusCode: 200,
        ),
      );

      await dataSource.getUserProfile(
        id: idTest,
      );

      verify(mockHttpClient.getFirebaseData(
        endPoint: anyNamed('endPoint'),
      ));
    });
    test('should return Customer', () async {
      when(mockHttpClient.getFirebaseData(
        endPoint: anyNamed('endPoint'),
      )).thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          data: customerFixture,
          statusCode: 200,
        ),
      );

      final result = await dataSource.getUserProfile(id: idTest);

      expect(result, customer);
    });
    test('should return Staff', () async {
      when(mockHttpClient.getFirebaseData(
        endPoint: anyNamed('endPoint'),
      )).thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          data: staffFixture,
          statusCode: 200,
        ),
      );

      final result = await dataSource.getUserProfile(id: idTest);

      expect(result, staff);
    });
    test('should throw InvalidIdTokenException', () async {
      setUpResponseStatusCode(401);

      expect(
        () async => await dataSource.getUserProfile(id: idTest),
        throwsA(isA<InvalidIdTokenException>()),
      );
    });
    test('should throw NotFoundException', () async {
      setUpResponseStatusCode(404);

      expect(
        () async => await dataSource.getUserProfile(id: idTest),
        throwsA(isA<NotFoundException>()),
      );
    });
    test('should throw BadRequestException', () async {
      setUpResponseStatusCode(400);

      expect(
        () async => await dataSource.getUserProfile(id: idTest),
        throwsA(isA<BadRequestException>()),
      );
    });
    test('should throw InternalServerErrorException', () async {
      setUpResponseStatusCode(500);

      expect(
        () async => await dataSource.getUserProfile(id: idTest),
        throwsA(isA<InternalServerErrorException>()),
      );
    });
    test('should throw ServiceUnavailableException', () async {
      setUpResponseStatusCode(503);

      expect(
        () async => await dataSource.getUserProfile(id: idTest),
        throwsA(isA<ServiceUnavailableException>()),
      );
    });
    test('should throw PreconditionFailedException', () async {
      setUpResponseStatusCode(412);

      expect(
        () async => await dataSource.getUserProfile(id: idTest),
        throwsA(isA<PreconditionFailedException>()),
      );
    });
    test('should throw UnexpectedException', () async {
      setUpResponseStatusCode(501);

      expect(
        () async => await dataSource.getUserProfile(id: idTest),
        throwsA(isA<UnexpectedException>()),
      );
    });
  });
}
