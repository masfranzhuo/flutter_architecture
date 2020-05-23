import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_architecture/features/storage/data/data_sources/firebase_storage_data_source.dart';
import 'package:flutter_architecture/features/storage/domain/repositories/storage_repository.dart';
import 'package:flutter_architecture/features/storage/domain/use_cases/delete_file.dart';
import 'package:flutter_architecture/features/storage/domain/use_cases/upload_file.dart';
import 'package:flutter_architecture/features/storage/presentation/blocs/storage_bloc/storage_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/repositories/storage_repository_impl.dart';

void init() {
  // Bloc
  GetIt.I.registerFactory(
    () => StorageBloc(uploadFile: GetIt.I(), deleteFile: GetIt.I()),
  );

  // Use cases
  GetIt.I.registerLazySingleton(() => UploadFile(repository: GetIt.I()));
  GetIt.I.registerLazySingleton(() => DeleteFile(repository: GetIt.I()));

  // Repositories
  GetIt.I.registerLazySingleton<StorageRepository>(
    () => StorageRepositoryImpl(firebaseStorageDataSource: GetIt.I()),
  );

  // Data sources
  GetIt.I.registerLazySingleton<FirebaseStorageDataSource>(
    () => FirebaseStorageDataSourceImpl(firebaseStorageInstance: GetIt.I()),
  );

  // Firebase
  GetIt.I.registerLazySingleton(() => FirebaseStorage.instance);
}
