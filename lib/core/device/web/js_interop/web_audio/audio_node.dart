@JS()
library static_interop;

import 'package:js/js.dart';

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

@JS('AudioNode')
@staticInterop
class JSAudioNode {
  external factory JSAudioNode([AudioNodeOptions options]);
}

extension JSAudioNodeExtension on JSAudioNode {
  external void connect(JSAudioNode destination);
  external void disconnect(JSAudioNode destination);
  external JSAudioNode get context;
}

class AudioNode {
  final JSAudioNode _jsAudioNode;

  AudioNode(this._jsAudioNode);

  void connect(AudioNode destination) =>
      _jsAudioNode.connect(destination._jsAudioNode);

  void disconnect(AudioNode destination) =>
      _jsAudioNode.disconnect(destination._jsAudioNode);

  AudioNode get context => AudioNode(_jsAudioNode.context);
}
