import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/error/failures/failure.dart';
import 'package:flutter_architecture/features/storage/domain/use_cases/delete_file.dart'
    as df;
import 'package:flutter_architecture/features/storage/domain/use_cases/upload_file.dart'
    as uf;
import 'package:meta/meta.dart';

part 'storage_event.dart';
part 'storage_state.dart';
part 'map_failure_to_error.u.dart';

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  final uf.UploadFile uploadFile;
  final df.DeleteFile deleteFile;

  StorageBloc({
    @required this.uploadFile,
    @required this.deleteFile,
  });

  @override
  StorageState get initialState => StorageInitialState();

  @override
  Stream<StorageState> mapEventToState(
    StorageEvent event,
  ) async* {
    if (event is UploadImageEvent) {
      yield StorageLoadingState();

      final result = await uploadFile(uf.Params(
        file: event.file,
        fileType: event.fileType,
      ));

      yield result.fold(
        (failure) => _$mapFailureToError(failure),
        (url) => StorageUploadedState(url: url),
      );
    } else if (event is DeleteImageEvent) {
      yield StorageLoadingState();

      final result = await deleteFile(df.Params(url: event.url));

      yield result.fold(
        (failure) => _$mapFailureToError(failure),
        (_) => StorageDeletedState(),
      );
    }
  }
}
