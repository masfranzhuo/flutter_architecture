import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_architecture/core/error/exception.dart';
import 'package:flutter_architecture/features/account/data/data_sources/firebase_auth_data_source.dart';
import 'package:meta/meta.dart';

class Url {
  static const main = 'https://flutter-architecture-b8cfd.firebaseio.com';
  static const storage = 'https://flutter-architecture-b8cfd.firebaseio.com';
}

class EndPoint {
  static const auth = '/auth';
}

class HttpClient {
  final Dio dio;
  final FirebaseAuthDataSource firebaseAuthDataSource;

  HttpClient({
    @required this.firebaseAuthDataSource,
    Dio dioHttpClient,
  }) : dio = dioHttpClient == null
            ? Dio(BaseOptions(baseUrl: Url.main))
            : dioHttpClient;

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
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $idToken',
          },
        ),
      );

      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }
}
