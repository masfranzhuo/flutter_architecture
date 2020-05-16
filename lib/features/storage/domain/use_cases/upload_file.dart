import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/error/failure.dart';
import 'package:flutter_architecture/core/util/use_case.dart';
import 'package:flutter_architecture/features/storage/domain/repositories/storage_repository.dart';

class UploadFile extends UseCase<String, Params> {
  final StorageRepository repository;

  UploadFile({@required this.repository});

  @override
  Future<Either<Failure, String>> call(Params params) async {
    return await repository.uploadFile(
      filePath: params.filePath,
      fileType: params.fileType,
    );
  }
}

class Params extends Equatable {
  final String filePath, fileType;

  Params({
    @required this.filePath,
    @required this.fileType,
  });

  @override
  List<Object> get props => [filePath, fileType];
}
