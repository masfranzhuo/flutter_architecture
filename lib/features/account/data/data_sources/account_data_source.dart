import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:meta/meta.dart';

abstract class AccountDataSource {
  /// Login to backend and get either Customer or Staff in return.
  /// or
  /// Set device token
  // Future<Account> loginToBackend({@required String deviceToken});
  Future<bool> setDeviceToken(
      {@required String deviceToken, @required String id});

  /// Logout from backend. If successful, will return true, otherwise and exception.
  /// or
  /// Remove device token
  // Future<bool> logoutFromBackend({@required String deviceToken});
  Future<bool> removeDeviceToken({@required String deviceToken});

  Future<Account> getUserProfile({String id});
}
