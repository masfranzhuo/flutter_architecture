import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/core/util/use_case.dart';
import 'package:flutter_architecture/features/storage/domain/repositories/storage_repository.dart';

class UploadFile extends UseCase<String, Params> {
  final StorageRepository repository;

  UploadFile({@required this.repository});

  @override
  Future<Either<Failure, String>> call(Params params) async {
    return await repository.uploadFile(
      file: params.file,
      fileType: params.fileType,
    );
  }
}

class Params extends Equatable {
  final File file;
  final String fileType;

  Params({
    @required this.file,
    @required this.fileType,
  });

  @override
  List<Object> get props => [file, fileType];
}
