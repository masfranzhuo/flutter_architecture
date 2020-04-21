import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_architecture/features/account/data/data_sources/firebase_messaging_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

void main() {
  FirebaseMessagingDataSourceImpl dataSource;
  MockFirebaseMessaging mockFirebaseMessaging;

  setUp(() {
    mockFirebaseMessaging = MockFirebaseMessaging();
    dataSource = FirebaseMessagingDataSourceImpl(
        firebaseMessagingInstance: mockFirebaseMessaging);
  });

  test('return return device token', () async {
    final deviceToken = 'deviceToken';

    when(mockFirebaseMessaging.getToken()).thenAnswer((_) async => deviceToken);

    final result = await dataSource.getDeviceToken();
    
    verify(dataSource.getDeviceToken());
    expect(result, deviceToken);
  });
}
