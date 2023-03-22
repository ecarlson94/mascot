import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';
import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:universal_html/html.dart';

import '../../../../core/device/web/js_interop/web_audio_js.dart';

@LazySingleton()
class MascotMicrophone {
  final AudioContext _audioContext;

  MascotMicrophone(this._audioContext);

  Future<bool> hasPermission() async {
    await _setStream();
    return _stream != null;
  }

  Stream<double> get volumeStream async* {
    final analyzer = await _getAnalyzer();
    final data = Float32List(analyzer.frequencyBinCount);

    Stream<double>.periodic(
      const Duration(milliseconds: 10),
      (_) {
        // get the audio data from the analyzer
        analyzer.getFloatTimeDomainData(data);

        // calculate the rms value of the audio data
        var sum = 0.0;
        for (final sample in data) {
          sum += sample * sample;
        }
        final rms = sqrt(sum / data.length);

        return rms;
      },
    );
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

      developer.log(
        message,
        name: 'MascotMicrophone',
        error: jsonEncode(e),
      );

      if (throwOnError) rethrow;
    }

    if (throwOnError && _stream == null) {
      throw Exception('Failed to get microphone stream');
    }
  }

  AnalyzerNode? _analyzer;
  Future<AnalyzerNode> _getAnalyzer() async {
    if (_analyzer == null) {
      final source = await _getSource();
      _analyzer = _audioContext.createAnalyser();
      source.connect(_analyzer!);
    }

    return _analyzer!;
  }

  MediaStreamAudioSourceNode? _source;
  Future<MediaStreamAudioSourceNode> _getSource() async {
    await _setStream(throwOnError: true);

    return _source ??= _audioContext.createMediaStreamSource(_stream!);
  }
}
