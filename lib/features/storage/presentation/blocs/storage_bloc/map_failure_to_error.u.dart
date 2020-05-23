part of 'storage_bloc.dart';

enum StorageErrorGroup { general }

StorageErrorState _$mapFailureToError(Failure failure) {
  StorageErrorGroup errorGroup = StorageErrorGroup.general;
  String message = 'Undefined Error. ${failure.code} - ${failure.message}';

 if (failure is InvalidIdTokenFailure) {
    message = 'Session expired';
  }

  return StorageErrorState(
    failure: failure,
    error: errorGroup,
    message: message,
  );
}
