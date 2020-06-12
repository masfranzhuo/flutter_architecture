import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/error/failures/http_failure.dart';
import 'package:flutter_architecture/features/account/domain/entities/account.dart';
import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/auto_login.dart';
import 'package:flutter_architecture/features/account/domain/use_cases/get_user_profile.dart'
    as gup;
import 'package:flutter_architecture/features/account/domain/use_cases/logout.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/account_bloc.dart';
import 'package:flutter_architecture/features/account/presentation/blocs/login_bloc/login_bloc.dart'
    as lb;
import 'package:flutter_architecture/features/account/presentation/blocs/register_bloc/register_bloc.dart'
    as rb;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLogout extends Mock implements Logout {}

class MockAutoLogin extends Mock implements AutoLogin {}

class MockLoginBloc extends Mock implements lb.LoginBloc {}

class MockRegisterBloc extends Mock implements rb.RegisterBloc {}

class MockGetUserProfile extends Mock implements gup.GetUserProfile {}

void main() {
  AccountBloc bloc;
  MockLogout mockLogout;
  MockAutoLogin mockAutoLogin;
  MockLoginBloc mockLoginBloc;
  MockRegisterBloc mockRegisterBloc;
  MockGetUserProfile mockGetUserProfile;

  final customer = Customer(
    id: 'fake_id',
    name: 'John Doe',
    email: 'john@doe.com',
    accountStatus: AccountStatus.active,
    phoneNumber: '1234567890',
    photoUrl: 'https://fakeimage.com/image.jpg',
    gender: Gender.male,
    birthPlace: 'Indonesia',
    birthDate: DateTime.now(),
  );

  setUp(() {
    mockLogout = MockLogout();
    mockAutoLogin = MockAutoLogin();
    mockLoginBloc = MockLoginBloc();
    mockRegisterBloc = MockRegisterBloc();
    mockGetUserProfile = MockGetUserProfile();
    bloc = AccountBloc(
      logout: mockLogout,
      autoLogin: mockAutoLogin,
      loginBloc: mockLoginBloc,
      registerBloc: mockRegisterBloc,
      getUserProfile: mockGetUserProfile,
    );
  });

  tearDown(() {
    bloc?.close();
    mockLoginBloc?.close();
    mockRegisterBloc?.close();
  });

  blocTest(
    'initial state should be initial',
    build: () async => bloc,
    skip: 0,
    expect: [AccountInitialState()],
  );

  group('LogoutEvent', () {
    blocTest(
      'should emit [AccountLoadingState, AccountLoadedState] account: null when Logout is successful',
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
      'should emit [AccountLoadingState, AccountErrorState] when Logout failed',
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

  group('AutoLoginEvent', () {
    blocTest(
      'should emit [AccountLoadingState, AccountLoadedState] when AutoLogin is successful',
      build: () async {
        when(mockAutoLogin(any)).thenAnswer((_) async => Right(customer));
        return bloc;
      },
      act: (bloc) => bloc.add(AutoLoginEvent()),
      expect: [
        AccountLoadingState(),
        AccountLoadedState(account: customer),
      ],
    );

    blocTest(
      'should emit [AccountLoadingState, AccountErrorState] when AutoLogin failed',
      build: () async {
        when(mockAutoLogin(any)).thenAnswer(
          (_) async => Left(UnauthorizedFailure()),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(AutoLoginEvent()),
      expect: [
        AccountLoadingState(),
        AccountErrorState(failure: UnauthorizedFailure()),
      ],
    );
  });

  group('GetUserProfileEvent', () {
    final idTest = 'fake_id';

    blocTest(
      'should emit [AccountLoadingState, AccountLoadedState] when getUserProfile is successful',
      build: () async {
        when(mockGetUserProfile(any)).thenAnswer((_) async => Right(customer));
        return bloc;
      },
      act: (bloc) => bloc.add(GetUserProfileEvent(id: idTest)),
      expect: [
        AccountLoadingState(),
        AccountLoadedState(account: customer),
      ],
    );

    blocTest(
      'should emit [AccountLoadingState, AccountErrorState] when getUserProfile failed',
      build: () async {
        when(mockGetUserProfile(any)).thenAnswer(
          (_) async => Left(InvalidIdTokenFailure()),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetUserProfileEvent(id: idTest)),
      expect: [
        AccountLoadingState(),
        AccountErrorState(failure: InvalidIdTokenFailure()),
      ],
    );
  });

  group('LoginEvent', () {
    blocTest(
      'should emit [AccountLoadingState, AccountLoadedState] when Login is successful',
      build: () async {
        return bloc;
      },
      act: (bloc) => bloc.add(LoginEvent(account: customer)),
      expect: [
        AccountLoadingState(),
        AccountLoadedState(account: customer),
      ],
    );
  });

  group('StreamSubscription', () {
    blocTest(
      'should emit [AccountLoadingState, AccountLoadedState] LoginLoadedState is successful',
      build: () async {
        when(mockLoginBloc.add(any)).thenAnswer(
          (_) async => lb.LoginLoadedState(account: customer),
        );

        return AccountBloc(
          logout: mockLogout,
          autoLogin: mockAutoLogin,
          loginBloc: mockLoginBloc,
          registerBloc: mockRegisterBloc,
          getUserProfile: mockGetUserProfile,
        );
      },
      act: (bloc) => bloc.add(LoginEvent(account: customer)),
      expect: [
        AccountLoadingState(),
        AccountLoadedState(account: customer),
      ],
    );

    blocTest(
      'should emit [AccountLoadingState, AccountLoadedState] RegisterLoadedState is successful',
      build: () async {
        when(mockRegisterBloc.add(any)).thenAnswer(
          (_) async => rb.RegisterLoadedState(account: customer),
        );

        return AccountBloc(
          logout: mockLogout,
          autoLogin: mockAutoLogin,
          loginBloc: mockLoginBloc,
          registerBloc: mockRegisterBloc,
          getUserProfile: mockGetUserProfile,
        );
      },
      act: (bloc) => bloc.add(LoginEvent(account: customer)),
      expect: [
        AccountLoadingState(),
        AccountLoadedState(account: customer),
      ],
    );
  });
}
