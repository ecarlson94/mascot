import 'dart:developer' as developer;

import 'package:flutter/material.dart';

abstract class Logger<T> {
  void log(String message) =>
      developer.log('INFO: $message', name: T.toString());

  void logError(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(
      'ERROR: $message',
      name: T.toString(),
      error: error,
      stackTrace: stackTrace,
    );
    debugPrint(message);
    debugPrint(error.toString());
    debugPrint(stackTrace.toString());
  }

  void logWarning(String message) => developer.log(
        'WARN: $message',
        name: T.toString(),
      );
}
