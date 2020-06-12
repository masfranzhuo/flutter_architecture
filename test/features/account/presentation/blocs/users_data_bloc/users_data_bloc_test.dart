import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/get_users_data.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/users_data_bloc/users_data_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetUsersData extends Mock implements GetUsersData {}

void main() {
  UsersDataBloc bloc;
  MockGetUsersData mockGetUsersData;

  setUp(() {
    mockGetUsersData = MockGetUsersData();
    bloc = UsersDataBloc(getUsersData: mockGetUsersData);
  });

  tearDown(() {
    bloc?.close();
  });

  blocTest(
    'initial state should be initial',
    build: () async => bloc,
    skip: 0,
    expect: [UsersDataInitialState()],
  );

  group('GetUsersData', () {
    final usersDataTest = <Map<String, dynamic>>[
      {'status': AccountStatus.active, 'count': 2},
      {'status': AccountStatus.inactive, 'count': 0}
    ];
    blocTest(
      'should emit [UsersDataLoadingState, UsersDataLoadedState] when getUsersData is successful',
      build: () async {
        when(mockGetUsersData(any)).thenAnswer(
          (_) async => Right(usersDataTest),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetUsersDataEvent()),
      expect: [
        UsersDataLoadingState(),
        UsersDataLoadedState(usersData: usersDataTest),
      ],
    );

    blocTest(
      'should emit [UsersDataLoadingState, UsersDataErrorState] when getUsersData failed',
      build: () async {
        when(mockGetUsersData(any)).thenAnswer(
          (_) async => Left(InvalidIdTokenFailure()),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetUsersDataEvent()),
      expect: [
        UsersDataLoadingState(),
        UsersDataErrorState(failure: InvalidIdTokenFailure()),
      ],
    );
  });
}
