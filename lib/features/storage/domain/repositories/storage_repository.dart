import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:meta/meta.dart';

abstract class StorageRepository {
  Future<Either<Failure, String>> uploadFile({
    @required File file,
    @required String fileType,
  });

  Future<Either<Failure, bool>> deleteFile({@required String url});
}
