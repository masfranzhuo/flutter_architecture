import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_architecture/core/error/exceptions/app_exception.dart';
import 'package:flutter_architecture/features/account/data/data_sources/firebase_auth_data_source.dart';
import 'package:meta/meta.dart';

class Url {
  static const main = 'https://flutter-architecture-b8cfd.firebaseio.com';
}

class EndPoint {
  static const auth = 'auth';
  static const users = '/users';
}

class HttpClient {
  static BaseOptions options = BaseOptions(
    baseUrl: Url.main,
    // connectTimeout: 5000,
    // receiveTimeout: 3000,
  );

  // TODO: Future<Account> getUserProfile({String id}) test cache ane network exception

  static DioCacheManager dioCacheManager = DioCacheManager(
    CacheConfig(baseUrl: Url.main),
  );

  final Dio dio;
  final FirebaseAuthDataSource firebaseAuthDataSource;

  HttpClient({
    @required this.firebaseAuthDataSource,
    Dio dioHttpClient,
  }) : dio = (dioHttpClient == null ? Dio(options) : dioHttpClient)
          ..interceptors.add(dioCacheManager.interceptor)
          ..interceptors.add(LogInterceptor(responseBody: true));

  Future<Response> postFormData({
    @required String endPoint,
    @required FormData formData,
  }) async {
    final idToken = await firebaseAuthDataSource.getCurrentUserIdToken();

    if (idToken == null || idToken.isEmpty) {
      throw InvalidIdTokenException();
    }

    try {
      final response = await dio.post(
        endPoint,
        data: formData,
        options: buildCacheOptions(
          Duration(days: 7),
          options: Options(
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $idToken',
            },
          ),
        ),
      );

      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response> getFirebaseData({
    @required String endPoint,
  }) async {
    final idToken = await firebaseAuthDataSource.getCurrentUserIdToken();

    if (idToken == null || idToken.isEmpty) {
      throw InvalidIdTokenException();
    }

    try {
      final response = await dio.get(
        '$endPoint?${EndPoint.auth}=$idToken',
      );

      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response> postFirebaseData({
    @required String endPoint,
    @required Map<String, dynamic> formData,
  }) async {
    final idToken = await firebaseAuthDataSource.getCurrentUserIdToken();

    if (idToken == null || idToken.isEmpty) {
      throw InvalidIdTokenException();
    }

    try {
      final response = await dio.post(
        '$endPoint?${EndPoint.auth}=$idToken',
        data: json.encode(formData),
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );

      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response> patchFirebaseData({
    @required String endPoint,
    @required Map<String, dynamic> formData,
  }) async {
    final idToken = await firebaseAuthDataSource.getCurrentUserIdToken();

    if (idToken == null || idToken.isEmpty) {
      throw InvalidIdTokenException();
    }

    try {
      final response = await dio.patch(
        '$endPoint?${EndPoint.auth}=$idToken',
        data: json.encode(formData),
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );

      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }
}
