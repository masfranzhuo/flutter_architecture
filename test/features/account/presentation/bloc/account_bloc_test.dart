import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failure.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/logout.dart';
import 'package:flutter_architecture/features/account/presentation/bloc/account_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLogout extends Mock implements Logout {}

void main() {
  AccountBloc bloc;
  MockLogout mockLogout;

  setUp(() {
    mockLogout = MockLogout();
    bloc = AccountBloc(logout: mockLogout);
  });

  tearDown(() {
    bloc?.close();
  });

  test('initial state should be initial', () {
    expect(bloc.initialState, isA<AccountInitialState>());
  });

  group('LogoutEvent', () {
    blocTest(
      'should emit [AccountLoadingState,AccountLoadedState]account: null when Logout is successful',
      build: () async {
        when(mockLogout(any)).thenAnswer((_) async => Right(true));
        return bloc;
      },
      act: (bloc) => bloc.add(LogoutEvent()),
      expect: [
        AccountLoadingState(),
        AccountLoadedState(account: null),
      ],
    );

    blocTest(
      'should emit [AccountLoadingState,AccountErrorState] when Logout failed',
      build: () async {
        when(mockLogout(any))
            .thenAnswer((_) async => Left(InvalidIdTokenFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(LogoutEvent()),
      expect: [
        AccountLoadingState(),
        AccountErrorState(failure: InvalidIdTokenFailure()),
      ],
    );
  });
}
