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
  );

  final Dio dio;
  final FirebaseAuthDataSource firebaseAuthDataSource;

  /// [true] to useinterceoptors
  bool isCached = false;
  bool isLogged = false;

  /// interceptors
  DioCacheManager dioCacheManager = DioCacheManager(
    CacheConfig(baseUrl: Url.main),
  );
  LogInterceptor logInterceptor = LogInterceptor(
    responseBody: true,
  );

  Duration cacheDuration = Duration(hours: 1);

  HttpClient({
    @required this.firebaseAuthDataSource,
    Dio dioHttpClient,
    this.isCached = false,
    this.isLogged = false,
  }) : dio = (dioHttpClient == null ? Dio(options) : dioHttpClient);

  set cache(bool isCached) {
    this.isCached = isCached;
  }

  set logger(bool isLogged) {
    this.isLogged = isLogged;
  }

  _interceptors() {
    if (this.isCached) {
      this.dio.interceptors.add(dioCacheManager.interceptor);
    }

    if (this.isLogged) {
      this.dio.interceptors.add(logInterceptor);
    }
  }

  Future<Response> postFormData({
    @required String endPoint,
    @required FormData formData,
  }) async {
    _interceptors();

    final idToken = await firebaseAuthDataSource.getCurrentUserIdToken();

    if (idToken == null || idToken.isEmpty) {
      throw InvalidIdTokenException();
    }

    try {
      final response = await dio.post(
        endPoint,
        data: formData,
        options: buildCacheOptions(
          cacheDuration,
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
    _interceptors();

    final idToken = await firebaseAuthDataSource.getCurrentUserIdToken();

    if (idToken == null || idToken.isEmpty) {
      throw InvalidIdTokenException();
    }

    try {
      final response = await dio.get(
        '$endPoint?${EndPoint.auth}=$idToken',
        options: buildCacheOptions(cacheDuration),
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
    _interceptors();

    final idToken = await firebaseAuthDataSource.getCurrentUserIdToken();

    if (idToken == null || idToken.isEmpty) {
      throw InvalidIdTokenException();
    }

    try {
      final response = await dio.post(
        '$endPoint?${EndPoint.auth}=$idToken',
        data: json.encode(formData),
        options: buildCacheOptions(
          cacheDuration,
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
          ),
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
    _interceptors();

    final idToken = await firebaseAuthDataSource.getCurrentUserIdToken();

    if (idToken == null || idToken.isEmpty) {
      throw InvalidIdTokenException();
    }

    try {
      final response = await dio.patch(
        '$endPoint?${EndPoint.auth}=$idToken',
        data: json.encode(formData),
        options: buildCacheOptions(
          cacheDuration,
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
          ),
        ),
      );

      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }
}
