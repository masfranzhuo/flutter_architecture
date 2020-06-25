import 'package:flutter_architecture/features/users_overview/presentation/blocs/users_list_bloc/users_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GetUsersEvent', () {
    final pageSizeTest = 5;
    final nodeIdTest = 'test01';
    test('props are [pageSize, nodeId]', () {
      expect(
        GetUsersEvent(pageSize: pageSizeTest, nodeId: nodeIdTest).props,
        [pageSizeTest, nodeIdTest],
      );
    });

    test('event stringify should be true', () {
      final event = GetUsersEvent(pageSize: pageSizeTest, nodeId: nodeIdTest);
      expect(event.stringify, true);
    });
  });
}
