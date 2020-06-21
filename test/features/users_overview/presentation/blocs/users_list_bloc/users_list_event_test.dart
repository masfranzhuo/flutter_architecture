import 'package:flutter_architecture/features/users_overview/presentation/blocs/users_list_bloc/users_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GetUsersEvent', () {
    test('props are [pageSize, nodeId]', () {
      final pageSizeTest = 5;
      final nodeIdTest = 'test01';
      expect(
        GetUsersEvent(pageSize: pageSizeTest, nodeId: nodeIdTest).props,
        [pageSizeTest, nodeIdTest],
      );
    });
  });
}
