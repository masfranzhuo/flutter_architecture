import 'package:dio/dio.dart';
import 'package:flutter_architecture/core/error/exception.dart';
import 'package:flutter_architecture/core/platform/http_client.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
import 'package:meta/meta.dart';

abstract class AccountDataSource {
  /// Login to backend and get either Customer or Staff in return.
  // Future<Account> loginToBackend({@required String deviceToken});
  Future<Account> setUserProfile({
    @required String id,
    @required String deviceToken,
    String name,
    String email,
    String photoUrl,
  });

  /// Logout from backend. If successful, will return true, otherwise and exception.
  // Future<bool> logoutFromBackend({@required String deviceToken});
  Future<bool> removeDeviceToken({
    @required String id,
    @required String deviceToken,
  });

  Future<Account> getUserProfile({String id});
}

class AccountDataSourceImpl extends AccountDataSource {
  final HttpClient client;

  AccountDataSourceImpl({@required this.client});

  @override
  Future<Account> setUserProfile({
    @required String id,
    @required String deviceToken,
    String name,
    String email,
    String photoUrl,
  }) async {
    Map<String, dynamic> formData;
    Response<dynamic> response;

    if (name != null && email != null) {
      // Register
      formData = <String, dynamic>{
        '_id': id,
        'token': deviceToken,
        'name': name,
        'email': email,
        'photoUrl': photoUrl,
        'accountStatus': AccountStatus.active,
      };
    } else {
      // Login
      formData = <String, dynamic>{
        'token': deviceToken,
        'accountStatus': AccountStatus.active,
      };
    }

    response = await client.patchFirebaseData(
      endPoint: '${EndPoint.users}/$id.json',
      formData: formData,
    );

    if (response.statusCode == 200) {
      final mappedAccountData = Map<String, dynamic>.from(response.data);

      if (mappedAccountData['role'] != null) {
        return Staff.fromJson(mappedAccountData);
      }

      return Customer.fromJson(mappedAccountData);
    }

    if (response.statusCode == 401) {
      throw InvalidIdTokenException();
    }

    if (response.statusCode == 404) {
      throw NotFoundException();
    }

    if (response.statusCode == 400) {
      throw BadRequestException();
    }

    if (response.statusCode == 500) {
      throw InternalServerErrorException();
    }

    if (response.statusCode == 503) {
      throw ServiceUnavailableException();
    }

    if (response.statusCode == 412) {
      throw PreconditionFailedException();
    }

    throw UnexpectedException();
  }

  @override
  Future<bool> removeDeviceToken(
      {@required String id, @required String deviceToken}) async {
    final formData = <String, dynamic>{
      'token': null,
    };

    final response = await client.patchFirebaseData(
      endPoint: '${EndPoint.users}/$id.json',
      formData: formData,
    );

    if (response.statusCode == 200) {
      return true;
    }

    if (response.statusCode == 401) {
      throw InvalidIdTokenException();
    }

    if (response.statusCode == 404) {
      throw NotFoundException();
    }

    if (response.statusCode == 400) {
      throw BadRequestException();
    }

    if (response.statusCode == 500) {
      throw InternalServerErrorException();
    }

    if (response.statusCode == 503) {
      throw ServiceUnavailableException();
    }

    if (response.statusCode == 412) {
      throw PreconditionFailedException();
    }

    throw UnexpectedException();
  }

  @override
  Future<Account> getUserProfile({String id}) async {
    final response = await client.getFirebaseData(
      endPoint: '${EndPoint.users}/$id.json',
    );

    if (response.statusCode == 200) {
      final mappedAccountData = Map<String, dynamic>.from(response.data);

      if (mappedAccountData['role'] != null) {
        return Staff.fromJson(mappedAccountData);
      }

      return Customer.fromJson(mappedAccountData);
    }

    if (response.statusCode == 401) {
      throw InvalidIdTokenException();
    }

    if (response.statusCode == 404) {
      throw NotFoundException();
    }

    if (response.statusCode == 400) {
      throw BadRequestException();
    }

    if (response.statusCode == 500) {
      throw InternalServerErrorException();
    }

    if (response.statusCode == 503) {
      throw ServiceUnavailableException();
    }

    if (response.statusCode == 412) {
      throw PreconditionFailedException();
    }

    throw UnexpectedException();
  }
}
