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
}
