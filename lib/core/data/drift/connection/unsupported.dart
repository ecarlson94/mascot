import 'package:drift/drift.dart';

QueryExecutor connect({bool isInMemory = false}) {
  throw UnsupportedError(
      'No suitable database implementation was found on this platform.');
}
