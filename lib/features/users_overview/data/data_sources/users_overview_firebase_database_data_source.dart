import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_architecture/core/platform/http_client.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
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
    dynamic data;
    if (pageSize != null) {
      if (nodeId != null) {
        /// next time fetch data with pagination
        data = await firebaseDatabase
            .reference()
            .child(EndPoint.users)
            .orderByKey()

            /// add one and remove one later after sort
            /// because startAt is equal and need to remove later
            .limitToFirst(pageSize + 1)
            .startAt(nodeId)
            .once()
            .then((snapshot) => snapshot.value);
      } else {
        /// first time fetch data with pagination
        data = await firebaseDatabase
            .reference()
            .child(EndPoint.users)
            .orderByKey()
            .limitToFirst(pageSize)
            .once()
            .then((snapshot) => snapshot.value);
      }
    } else {
      /// fetch all data
      data = await firebaseDatabase
          .reference()
          .child(EndPoint.users)
          .orderByKey()
          .once()
          .then((snapshot) => snapshot.value);
    }

    List<Account> users = <Account>[];
    for (var value in data.values) {
      // TODO: need factory design pattern here
      if (value['role'] != null) {
        final staff = Staff.fromJson(
          Map<String, dynamic>.from(value),
        );
        users.add(staff);
      } else {
        final customer = Customer.fromJson(
          Map<String, dynamic>.from(value),
        );
        users.add(customer);
      }
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
        'status': AccountStatus.active,
        'count': users
            .where((user) => user.accountStatus == AccountStatus.active)
            .length,
      },
      {
        'status': AccountStatus.inactive,
        'count': users
            .where((user) => user.accountStatus == AccountStatus.inactive)
            .length,
      },
    ];

    return result;
  }
}
