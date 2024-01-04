import 'dart:math' as math;
import 'dart:typed_data';

extension Float32ListExtensions on Float32List {
  double get rms {
    // calculate the rms value of the audio data
    var sum = 0.0;
    for (final sample in this) {
      sum += sample * sample;
    }
    return math.sqrt(sum / length);
  }

  double get db {
    // convert the rms value to decibels (dB)
    return 20.0 * math.log(rms) / math.ln10;
  }

  double get loudness {
    // calculate loudness in LUFS (Loudness Units Full Scale)
    return db + 23.0;
  }
}
