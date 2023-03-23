abstract class ErrorState {
  final int code;

  const ErrorState(this.code);
}

abstract class ErrorCodes {
  static const int unknownFailureCode = 0;
  static const int invalidXfileFailureCode = 100;
  static const int addImageFailureCode = 101;
  static const int getImageFailureCode = 102;
  static const int saveMascotFailureCode = 103;
  static const int getMascotFailureCode = 104;
  static const int loadSettingsFailureCode = 105;
  static const int loadMascotFailureCode = 106;
  static const int noMicrophonePermissionFailueCode = 200;
  static const int microphoneFailureCode = 201;
}
