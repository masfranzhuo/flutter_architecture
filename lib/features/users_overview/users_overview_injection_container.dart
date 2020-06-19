import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_architecture/features/users_overview/data/data_sources/users_overview_firebase_database_data_source.dart';
import 'package:flutter_architecture/features/users_overview/data/repositories/users_overview_repository_impl.dart';
import 'package:flutter_architecture/features/users_overview/domain/repositories/users_overview_repository.dart';
import 'package:flutter_architecture/features/users_overview/domain/use_cases/get_users.dart';
import 'package:flutter_architecture/features/users_overview/domain/use_cases/get_users_data.dart';
import 'package:flutter_architecture/features/users_overview/presentation/blocs/users_overview_bloc/users_overview_bloc.dart';
import 'package:get_it/get_it.dart';

void init() {
  // Bloc
  GetIt.I.registerFactory(() => UsersOverviewBloc(getUsersData: GetIt.I()));

  // Use cases
  GetIt.I.registerLazySingleton(() => GetUsers(repository: GetIt.I()));
  GetIt.I.registerLazySingleton(() => GetUsersData(repository: GetIt.I()));

  // Repositories
  GetIt.I.registerLazySingleton<UsersOverviewRepository>(
    () => UsersOverviewRepositoryImpl(
      firebaseDatabaseDataSource: GetIt.I(),
    ),
  );

  // Data sources
  GetIt.I.registerLazySingleton<UsersOverviewFirebaseDatabaseDataSource>(
    () => UsersOverviewFirebaseDatabaseDataSourceImpl(
      firebaseDatabase: GetIt.I(),
    ),
  );

  // Firebase
  GetIt.I.registerLazySingleton(() => FirebaseDatabase.instance);
}
