import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_architecture/core/platform/http_client.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
import 'package:meta/meta.dart';

abstract class FirebaseRealtimeDataSource {
  Future<List<Account>> getUsers();

  /// Currently get users data by status for showing in graph
  Future<List<Map<String, dynamic>>> getUsersData();
}

class FirebaseRealtimeDataSourceImpl extends FirebaseRealtimeDataSource {
  final FirebaseDatabase firebaseDatabase;

  FirebaseRealtimeDataSourceImpl({@required this.firebaseDatabase});

  @override
  Future<List<Account>> getUsers() async {
    final data = await firebaseDatabase
        .reference()
        .child(EndPoint.users)
        .once()
        .then((snapshot) => snapshot.value);

    List<Account> users = <Account>[];
    for (var value in data.values) {
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

    /// TODO:
    /// add in different bloc for this 2 use cases
    return result;
  }
}
