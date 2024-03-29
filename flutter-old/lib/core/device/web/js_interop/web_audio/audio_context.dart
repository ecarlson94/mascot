@JS()
library static_interop;

import 'package:injectable/injectable.dart';
import 'package:js/js.dart';
import 'package:universal_html/html.dart';

import 'analyser_node.dart';
import 'media_stream_audio_source_node.dart';

@JS()
@staticInterop
@anonymous
class AudioContextOptions {
  external factory AudioContextOptions({
    dynamic latencyHint = 'interactive',
    num sampleRate,
    dynamic sinkId,
  });
}

@JS('AudioContext')
@staticInterop
class JSAudioContext {
  external factory JSAudioContext([AudioContextOptions options]);
}

extension JSAudioContextExtension on JSAudioContext {
  external JSMediaStreamAudioSourceNode createMediaStreamSource(
    MediaStream stream,
  );

  external JSAnalyserNode createAnalyser();

  external void close();
  external void resume();
}

@lazySingleton
class AudioContext {
  final JSAudioContext _jsAudioContext;

  AudioContext() : _jsAudioContext = JSAudioContext()..resume();

  MediaStreamAudioSourceNode createMediaStreamSource(MediaStream stream) =>
      MediaStreamAudioSourceNode(
        _jsAudioContext.createMediaStreamSource(stream),
      );

  AnalyserNode createAnalyser() =>
      AnalyserNode(_jsAudioContext.createAnalyser());

  void close() => _jsAudioContext.close();

  @disposeMethod
  void dispose() => close();
}
