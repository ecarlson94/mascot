@JS()
library static_interop;

import 'package:flutter/foundation.dart';
import 'package:js/js.dart';
import 'package:universal_html/html.dart';

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

@JS()
@staticInterop
class AudioContext {
  external factory AudioContext([AudioContextOptions options]);
}

extension AudioContextExtension on AudioContext {
  external MediaStreamAudioSourceNode createMediaStreamSource(
    MediaStream stream,
  );

  external AnalyzerNode createAnalyser();

  external void close();
}

@JS()
@staticInterop
class MediaStreamAudioSourceNode extends AudioNode {
  external factory MediaStreamAudioSourceNode();
}

@JS()
@staticInterop
class AnalyzerNode extends AudioNode {
  external factory AnalyzerNode();
}

extension AnalyzerNodeExtension on AnalyzerNode {
  external void getFloatTimeDomainData(Float32List array);
  external int get frequencyBinCount;
}

@JS()
@staticInterop
@anonymous
class AudioNodeOptions {
  external factory AudioNodeOptions({
    int channelCount,
    String channelCountMode,
    String channelInterpretation,
  });
}

@JS()
@staticInterop
class AudioNode extends EventTarget {
  external factory AudioNode([AudioNodeOptions options]);
}

extension AudioNodeExtension on AudioNode {
  external void connect(AudioNode destination, [int output, int input]);
  external void disconnect(AudioNode destination, [int output, int input]);
  external AudioNode get context;
}
