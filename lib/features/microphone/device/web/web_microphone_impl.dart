import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:universal_html/html.dart';

import '../../../../core/device/web/audio_context.dart';
import '../../../../core/device/web/js_interop/web_audio_js.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/models/decibel_lufs.dart';

@Injectable(as: Logger<WebMicrophoneImpl>)
class MascotMicrophoneLogger extends Logger<WebMicrophoneImpl> {}

abstract class WebMicrophone {
  Future<bool> hasPermission();
  Stream<DecibelLufs> get volumeStream;
}

@LazySingleton(as: WebMicrophone)
class WebMicrophoneImpl implements WebMicrophone {
  final WebAudio _webAudio;
  final Logger<WebMicrophoneImpl> _logger;

  WebMicrophoneImpl(this._webAudio, this._logger);

  @override
  Future<bool> hasPermission() async {
    await _setStream();
    return _stream != null;
  }

  @override
  Stream<DecibelLufs> get volumeStream async* {
    final analyzer = await _getAnalyzer();
    final data = Float32List(analyzer.frequencyBinCount);

    while (true) {
      // get the audio data from the analyzer
      analyzer.getFloatTimeDomainData(data);

      // calculate the rms value of the audio data
      var sum = 0.0;
      for (final sample in data) {
        sum += sample * sample;
      }
      rms() => math.sqrt(sum / data.length);

      // Convert RMS value to decibels (dB)
      dB() => 20.0 * math.log(rms()) / math.ln10;

      // Calculate loudness in LUFS (Loudness Units Full Scale)
      loudness() => dB() + 23.0;

      yield DecibelLufs(loudness());

      await Future.delayed(const Duration(milliseconds: 10));
    }
  }

  MediaStream? _stream;
  Future<void> _setStream({bool throwOnError = false}) async {
    try {
      _stream ??= await window.navigator.mediaDevices?.getUserMedia({
        'audio': true,
      });
    } catch (e) {
      var message = 'Error getting microphone stream:';
      if (e is DomException && e.name == 'NotAllowedError') {
        message = 'Microphone permission denied:';
      }

      _logger.logError(
        message,
        e,
      );

      if (throwOnError) rethrow;
    }

    if (throwOnError && _stream == null) {
      var e = Exception('Failed to get microphone stream');
      _logger.logError(e.toString(), e);
      throw e;
    }
  }

  AnalyzerNode? _analyzer;
  Future<AnalyzerNode> _getAnalyzer() async {
    if (_analyzer == null) {
      final source = await _getSource();
      _analyzer = _webAudio.context.createAnalyser();
      source.connect(_analyzer!);
    }

    return _analyzer!;
  }

  MediaStreamAudioSourceNode? _source;
  Future<MediaStreamAudioSourceNode> _getSource() async {
    await _setStream(throwOnError: true);

    return _source ??= _webAudio.context.createMediaStreamSource(_stream!);
  }
}
