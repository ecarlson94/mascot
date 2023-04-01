import 'dart:developer' as developer;

abstract class Logger<T> {
  void log(String message) =>
      developer.log('INFO: $message', name: T.toString());

  void logError(String message, [Object? error, StackTrace? stackTrace]) => {
        developer.log(
          'ERROR: $message',
          name: T.toString(),
          error: error,
          stackTrace: stackTrace,
        ),
      };

  void logWarning(String message) => developer.log(
        'WARN: $message',
        name: T.toString(),
      );
}
