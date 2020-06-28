import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_architecture/core/platform/http_client.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/factories/account_factory.dart';
import 'package:meta/meta.dart';

abstract class UsersOverviewFirebaseDatabaseDataSource {
  Future<List<Account>> getUsers({int pageSize, String nodeId, String query});

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
  Future<List<Account>> getUsers({
    int pageSize,
    String nodeId,
    String query,
  }) async {
    Query firebaseQuery = firebaseDatabase.reference().child(EndPoint.users);

    if (query != null) {
      /// only query the [name] key
      firebaseQuery = firebaseQuery.orderByChild('name').equalTo(query);
    } else {
      firebaseQuery = firebaseQuery.orderByKey();
    }

    if (pageSize != null) {
      if (nodeId != null) {
        /// next time fetch data with pagination
        /// add one [pageSize] and remove one later after sort
        /// because startAt is equal and need to remove later
        firebaseQuery =
            firebaseQuery.startAt(nodeId).limitToFirst(pageSize + 1);
      } else {
        /// first time fetch data with pagination
        firebaseQuery = firebaseQuery.limitToFirst(pageSize);
      }
    }

    final data = await firebaseQuery.once().then((snapshot) => snapshot.value);

    List<Account> users = <Account>[];
    if (data != null) {
      for (var value in data.values) {
        users.add(AccountFactory.accountFromJson(
          Map<String, dynamic>.from(value),
        ));
      }

      users.sort((a, b) => a.id.compareTo(b.id));
      if (nodeId != null) users.removeAt(0);
    }

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
