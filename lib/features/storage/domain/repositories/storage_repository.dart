import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failure.dart';
import 'package:meta/meta.dart';

abstract class StorageRepository {
  Future<Either<Failure, String>> uploadFile({
    @required String filePath,
    @required String fileType,
  });

  Future<Either<Failure, String>> deleteFile({@required String url});
}
