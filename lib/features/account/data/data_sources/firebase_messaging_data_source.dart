import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';

abstract class FirebaseMessagingDataSource {
  Future<String> getDeviceToken();
}

class FirebaseMessagingDataSourceImpl extends FirebaseMessagingDataSource {
  final FirebaseMessaging firebaseMessagingInstance;

  FirebaseMessagingDataSourceImpl({@required this.firebaseMessagingInstance});

  @override
  Future<String> getDeviceToken() async {
    return await firebaseMessagingInstance.getToken();
  }
}
