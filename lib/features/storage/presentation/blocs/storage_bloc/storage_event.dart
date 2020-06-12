part of 'storage_bloc.dart';

abstract class StorageEvent extends Equatable {
  const StorageEvent();

  @override
  List<Object> get props => null;
}

class UploadImageEvent extends StorageEvent {
  final File file;
  final String fileType;

  UploadImageEvent({
    @required this.file,
    @required this.fileType,
  });

  @override
  List<Object> get props => [file, fileType];
}

class DeleteImageEvent extends StorageEvent {
  final String url;

  DeleteImageEvent({@required this.url});

  @override
  List<Object> get props => [url];
}
