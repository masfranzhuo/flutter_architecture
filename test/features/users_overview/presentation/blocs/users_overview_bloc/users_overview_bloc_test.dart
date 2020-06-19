import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/users_overview/domain/use_cases/get_users_data.dart';
import 'package:flutter_architecture/features/users_overview/presentation/blocs/users_overview_bloc/users_overview_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetUsersData extends Mock implements GetUsersData {}

void main() {
  UsersOverviewBloc bloc;
  MockGetUsersData mockGetUsersData;

  setUp(() {
    mockGetUsersData = MockGetUsersData();
    bloc = UsersOverviewBloc(getUsersData: mockGetUsersData);
  });

  tearDown(() {
    bloc?.close();
  });

  blocTest(
    'initial state should be initial',
    build: () async => bloc,
    skip: 0,
    expect: [UsersOverviewInitialState()],
  );

  group('GetUsersData', () {
    final usersDataTest = <Map<String, dynamic>>[
      {'status': AccountStatus.active, 'count': 2},
      {'status': AccountStatus.inactive, 'count': 0}
    ];
    blocTest(
      'should emit [UsersOverviewLoadingState, UsersOverviewLoadedState] when getUsersData is successful',
      build: () async {
        when(mockGetUsersData(any)).thenAnswer(
          (_) async => Right(usersDataTest),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetUsersDataEvent()),
      expect: [
        UsersOverviewLoadingState(),
        UsersOverviewLoadedState(usersData: usersDataTest),
      ],
    );

    blocTest(
      'should emit [UsersOverviewLoadingState, UsersOverviewErrorState] when getUsersData failed',
      build: () async {
        when(mockGetUsersData(any)).thenAnswer(
          (_) async => Left(InvalidIdTokenFailure()),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetUsersDataEvent()),
      expect: [
        UsersOverviewLoadingState(),
        UsersOverviewErrorState(failure: InvalidIdTokenFailure()),
      ],
    );
  });
}
