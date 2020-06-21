import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_architecture/features/users_overview/domain/use_cases/get_users.dart';
import 'package:flutter_architecture/features/users_overview/presentation/blocs/users_list_bloc/users_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

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

  blocTest(
    'initial state should be initial',
    build: () async => bloc,
    skip: 0,
    expect: [UsersListLoadedState()],
  );
}
