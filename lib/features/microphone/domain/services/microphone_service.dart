import 'package:rxdart_ext/rxdart_ext.dart';

import '../models/decibel_lufs.dart';

typedef VolumeStream = Stream<DecibelLufs>;

abstract class MicrophoneService {
  Single<bool> hasPermission();
  VolumeStream getVolumeStream();
}
