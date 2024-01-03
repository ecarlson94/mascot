abstract class ErrorState {
  final int code;

  const ErrorState(this.code);
}

abstract class ErrorCodes {
  static const int unknownFailure = 0;
  static const int invalidInputFailure = 100;
  static const int addImageFailure = 101;
  static const int getImageFailure = 102;
  static const int saveMascotFailure = 103;
  static const int getMascotFailure = 104;
  static const int loadSettingsFailure = 105;
  static const int loadMascotFailure = 106;
  static const int microphonePermissionFailure = 200;
  static const int cameraPermissionFailure = 201;
  static const int cameraRetrievalFailure = 202;
}
