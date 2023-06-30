import 'package:rxdart_ext/rxdart_ext.dart';

import '../domain/models/decibel_lufs.dart';

abstract class Microphone {
  Single<bool> hasPermission();
  Stream<DecibelLufs> get volumeStream;
}
