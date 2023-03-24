import '../domain/models/decibel_lufs.dart';

abstract class Microphone {
  Future<bool> hasPermission();
  Stream<DecibelLufs> get volumeStream;
}
