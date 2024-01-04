import '../clean_architecture/entity.dart';

class ArgumentException implements Exception {
  final String message;
  const ArgumentException([this.message = '']);
}

class LocalDataSourceException implements Exception {
  final Object error;
  final StackTrace? stackTrace;

  const LocalDataSourceException(this.error, this.stackTrace);
}

class ObjectNotFoundException implements Exception {
  final Id id;
  final Type objectType;
  String get message => 'Object with id $id of type $objectType not found';

  const ObjectNotFoundException(this.id, this.objectType);
}

class MicrophonePermissionException implements Exception {
  final String message;
  const MicrophonePermissionException([this.message = '']);
}

class CameraPermissionException implements Exception {
  final String message;
  const CameraPermissionException([this.message = '']);
}
