import '../models/decibel_lufs.dart';

typedef VolumeStream = Stream<DecibelLufs>;

abstract class MicrophoneService {
  VolumeStream getVolumeStream();
}
