import 'dart:async';
import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../core/device/web/js_interop/web_audio/web_audio.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/models/decibel_lufs.dart';
import '../microphone.dart';

@Injectable(as: Logger<WebMicrophone>)
class MascotMicrophoneLogger extends Logger<WebMicrophone> {}

@LazySingleton(as: Microphone)
class WebMicrophone implements Microphone {
  final html.Window _webWindow;
  final AudioContext _webAudio;
  final Logger<WebMicrophone> _logger;

  WebMicrophone(this._webWindow, this._webAudio, this._logger);

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

      yield DecibelLufs(data.loudness);

      await Future.delayed(const Duration(milliseconds: 10));
    }
  }

  html.MediaStream? _stream;
  Future<void> _setStream({bool throwOnError = false}) async {
    try {
      _stream ??= await _webWindow.navigator.mediaDevices?.getUserMedia({
        'audio': true,
      });
    } catch (e) {
      var message = 'Error getting microphone stream:';
      if (e is html.DomException && e.name == 'NotAllowedError') {
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
      _analyzer = _webAudio.createAnalyser();
      source.connect(_analyzer!);
    }

    return _analyzer!;
  }

  MediaStreamAudioSourceNode? _source;
  Future<MediaStreamAudioSourceNode> _getSource() async {
    await _setStream(throwOnError: true);

    return _source ??= _webAudio.createMediaStreamSource(_stream!);
  }
}
