import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/users_overview/domain/use_cases/get_users.dart';
import 'package:flutter_architecture/features/users_overview/presentation/blocs/users_list_bloc/users_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixtures_reader.dart';

class MockGetUsers extends Mock implements GetUsers {}

void main() {
  UsersListBloc bloc;
  MockGetUsers mockGetUsers;

  setUp(() {
    mockGetUsers = MockGetUsers();
    bloc = UsersListBloc(getUsers: mockGetUsers);
  });

  tearDown(() {
    bloc?.close();
  });

  group('GetUsersEvent', () {
    final jsonFixtures = List<dynamic>.from(
      json.decode(fixture('fixtures/customers/collection.json')),
    );
    final usersTest = jsonFixtures
        .map((e) => Customer.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    blocTest(
      'should emit [UsersListLoadingState, UsersListLoadedState] when getUsersData is successful',
      build: () async {
        when(mockGetUsers(any)).thenAnswer(
          (_) async => Right(usersTest),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetUsersEvent()),
      expect: [
        UsersListLoadedState.empty().copyWith(isLoading: true),
        UsersListLoadedState(users: usersTest, isLoading: false),
      ],
    );

    blocTest(
      'should emit [UsersListLoadingState, UsersListErrorState] when getUsersData failed',
      build: () async {
        when(mockGetUsers(any)).thenAnswer(
          (_) async => Left(InvalidIdTokenFailure()),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetUsersEvent()),
      expect: [
        UsersListLoadedState.empty().copyWith(isLoading: true),
        UsersListErrorState(failure: InvalidIdTokenFailure()),
      ],
    );
  });
}
