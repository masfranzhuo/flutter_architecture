part of 'storage_bloc.dart';

abstract class StorageState extends Equatable {
  const StorageState();

  @override
  List<Object> get props => [];
}

class StorageInitialState extends StorageState {}

class StorageLoadingState extends StorageState {}

class StorageUploadedState extends StorageState {
  final String url;

  StorageUploadedState({@required this.url});

  @override
  List<Object> get props => [url];
}

class StorageDeletedState extends StorageState {}

class StorageErrorState extends StorageState {
  final Failure failure;
  final StorageErrorGroup error;
  final String message;

  StorageErrorState({
    @required this.failure,
    this.error,
    this.message,
  });

  @override
  List<Object> get props => [failure];
}
