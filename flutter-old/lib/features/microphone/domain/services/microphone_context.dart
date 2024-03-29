import 'package:rxdart_ext/rxdart_ext.dart';

import '../models/decibel_lufs.dart';

typedef VolumeStream = Stream<DecibelLufs>;

abstract class MicrophoneContext {
  Single<bool> hasPermission();
  VolumeStream getVolumeStream();
}
