import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_architecture/core/error/exceptions/app_exception.dart';
import 'package:flutter_architecture/core/platform/http_client.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/factories/account_factory.dart';
import 'package:meta/meta.dart';

abstract class UsersOverviewFirebaseDatabaseDataSource {
  Future<List<Account>> getUsers({int pageSize, String nodeId});

  /// Currently get users data by status for showing in graph
  Future<List<Map<String, dynamic>>> getUsersData();
}

class UsersOverviewFirebaseDatabaseDataSourceImpl
    extends UsersOverviewFirebaseDatabaseDataSource {
  final FirebaseDatabase firebaseDatabase;

  UsersOverviewFirebaseDatabaseDataSourceImpl({
    @required this.firebaseDatabase,
  });

  @override
  Future<List<Account>> getUsers({int pageSize, String nodeId}) async {
    Query query =
        firebaseDatabase.reference().child(EndPoint.users).orderByKey();

    if (pageSize != null) {
      if (nodeId != null) {
        /// next time fetch data with pagination
        /// add one [pageSize] and remove one later after sort
        /// because startAt is equal and need to remove later
        query = query.limitToFirst(pageSize + 1).startAt(nodeId);
      } else {
        /// first time fetch data with pagination
        query = query.limitToFirst(pageSize);
      }
    }

    final data =
        await query.once().then((snapshot) => snapshot.value).catchError((e) {
      // TODO: doesn't work, exception not catched
      throw UnexpectedException(message: e.toString());
    });

    List<Account> users = <Account>[];
    for (var value in data.values) {
      users.add(AccountFactory.accountFromJson(
        Map<String, dynamic>.from(value),
      ));
    }

    users.sort((a, b) => a.id.compareTo(b.id));
    if (nodeId != null) users.removeAt(0);

    return users;
  }

  @override
  Future<List<Map<String, dynamic>>> getUsersData() async {
    final users = await getUsers();

    final List<Map<String, dynamic>> result = [
      {
        'status': AccountStatus.accountStatusLabel[AccountStatus.active],
        'count': users
            .where((user) => user.accountStatus == AccountStatus.active)
            .length,
      },
      {
        'status': AccountStatus.accountStatusLabel[AccountStatus.inactive],
        'count': users
            .where((user) => user.accountStatus == AccountStatus.inactive)
            .length,
      },
    ];

    return result;
  }
}
