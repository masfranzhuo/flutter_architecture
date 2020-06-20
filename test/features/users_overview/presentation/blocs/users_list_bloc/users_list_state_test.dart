import 'dart:convert';

import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/users_overview/presentation/blocs/users_list_bloc/users_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixtures/fixtures_reader.dart';

void main() {
  group('UsersListLoadedState', () {
    final jsonFixtures = List<dynamic>.from(
      json.decode(fixture('fixtures/customers/collection.json')),
    );
    final usersTest = jsonFixtures
        .map((e) => Customer.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    final isLoading = true;

    test('should copy correctly with new result', () {
      final state = UsersListLoadedState.empty();
      final result = state.copyWith(
        users: usersTest,
        isLoading: isLoading,
      );

      expect(result.users, usersTest);
      expect(result.isLoading, isLoading);
    });
  });
}
