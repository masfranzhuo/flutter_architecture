import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/exception_converter.dart';
import 'package:flutter_architecture/core/error/failure.dart';
import 'package:flutter_architecture/features/storage/data/data_sources/firebase_storage_data_source.dart';
import 'package:flutter_architecture/features/storage/domain/repositories/storage_repository.dart';
import 'package:meta/meta.dart';

class StorageRepositoryImpl extends StorageRepository {
  final FirebaseStorageDataSource firebaseStorageDataSource;

  StorageRepositoryImpl({@required this.firebaseStorageDataSource});

  @override
  Future<Either<Failure, String>> uploadFile({
    @required String filePath,
    @required String fileType,
  }) async {
    try {
      final url = await firebaseStorageDataSource.storageUploadTask(
        filePath: filePath,
        fileType: fileType,
      );

      return Right(url);
    } on Exception catch (e) {
      return Left(convertExceptionToFailure(exception: e));
    }
  }

  @override
  Future<Either<Failure, String>> deleteFile({@required String url}) async {
    try {
      final resultUrl = await firebaseStorageDataSource.deleteStorageFile(
        url: url,
      );

      return Right(resultUrl);
    } on Exception catch (e) {
      return Left(convertExceptionToFailure(exception: e));
    }
  }
}
