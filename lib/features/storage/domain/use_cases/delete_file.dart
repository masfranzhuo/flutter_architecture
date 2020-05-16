import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/error/failure.dart';
import 'package:flutter_architecture/core/util/use_case.dart';
import 'package:flutter_architecture/features/storage/domain/repositories/storage_repository.dart';

class DeleteFile extends UseCase<String, Params> {
  final StorageRepository repository;

  DeleteFile({@required this.repository});

  @override
  Future<Either<Failure, String>> call(Params params) async {
    return await repository.deleteFile(url: params.url);
  }
}

class Params extends Equatable {
  final String url;

  Params({@required this.url});

  @override
  List<Object> get props => [url];
}
