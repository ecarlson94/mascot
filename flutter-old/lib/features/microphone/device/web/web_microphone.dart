import 'dart:async';
import 'dart:typed_data';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart_ext/rxdart_ext.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../core/device/web/js_interop/web_audio/web_audio.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/models/decibel_lufs.dart';
import '../microphone.dart';

@Injectable(as: Logger<WebMicrophone>)
class MascotMicrophoneLogger extends Logger<WebMicrophone> {}

@LazySingleton(as: Microphone)
class WebMicrophone implements Microphone, Disposable {
  final AudioContext _webAudio;
  final Logger<WebMicrophone> _logger;
  final StreamController<DecibelLufs> _volumeStreamController =
      StreamController.broadcast();

  Timer? _volumeUpdateTimer;
  html.MediaStream? _microphoneStream;
  AnalyserNode? _analyzer;
  MediaStreamAudioSourceNode? _source;

  WebMicrophone(this._webAudio, this._logger);

  @override
  Single<bool> hasPermission() =>
      _setMicrophoneStream().asSingle().map((_) => _microphoneStream != null);

  @override
  Stream<DecibelLufs> get volumeStream =>
      _setMicrophoneStream(throwOnError: true)
          .asSingle()
          .doOnData((_) => _startVolumeUpdates())
          .switchMap((_) => _volumeStreamController.stream);

  void _startVolumeUpdates() async {
    if (_volumeUpdateTimer != null) {
      return; // Timer already started
    }

    final analyzer = await _getAnalyzer();
    final data = Float32List(analyzer.frequencyBinCount);

    _volumeUpdateTimer = Timer.periodic(
      const Duration(milliseconds: 17), // ~60fps
      (_) {
        // get the audio data from the analyzer
        analyzer.getFloatTimeDomainData(data);

        _volumeStreamController.add(DecibelLufs(data.loudness));
      },
    );
  }

  Future<void> _setMicrophoneStream({bool throwOnError = false}) async {
    if (_microphoneStream != null) {
      return; // Stream alread set
    }

    try {
      _microphoneStream ??=
          await html.window.navigator.mediaDevices?.getUserMedia({
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

    if (throwOnError && _microphoneStream == null) {
      var e = Exception('Failed to get microphone stream');
      _logger.logError(e.toString(), e);
      throw e;
    }
  }

  Future<AnalyserNode> _getAnalyzer() async {
    if (_analyzer == null) {
      final source = await _getSource();
      _analyzer = _webAudio.createAnalyser();
      source.connect(_analyzer!);
    }

    return _analyzer!;
  }

  Future<MediaStreamAudioSourceNode> _getSource() async {
    await _setMicrophoneStream(throwOnError: true);

    return _source ??= _webAudio.createMediaStreamSource(_microphoneStream!);
  }

  @override
  FutureOr onDispose() {
    _volumeStreamController.close();
    _volumeUpdateTimer?.cancel();
    _volumeUpdateTimer = null;
  }
}
