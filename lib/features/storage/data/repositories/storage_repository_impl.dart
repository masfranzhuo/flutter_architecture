import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/exceptions/app_exception.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/features/storage/data/data_sources/firebase_storage_data_source.dart';
import 'package:flutter_architecture/features/storage/domain/repositories/storage_repository.dart';
import 'package:meta/meta.dart';

class StorageRepositoryImpl extends StorageRepository {
  final FirebaseStorageDataSource firebaseStorageDataSource;

  StorageRepositoryImpl({@required this.firebaseStorageDataSource});

  @override
  Future<Either<Failure, String>> uploadFile({
    @required File file,
    @required String fileType,
  }) async {
    try {
      final url = await firebaseStorageDataSource.storageUploadTask(
        file: file,
        fileType: fileType,
      );

      return Right(url);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } on Exception catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteFile({@required String url}) async {
    try {
      await firebaseStorageDataSource.deleteStorageFile(
        url: url,
      );

      return Right(true);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } on Exception catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
