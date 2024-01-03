@JS()
library static_interop;

import 'package:js/js.dart';
import 'package:universal_html/html.dart';

import 'audio_node.dart';

@JS('MediaStreamAudioSourceNode')
@staticInterop
class JSMediaStreamAudioSourceNode extends JSAudioNode {
  external factory JSMediaStreamAudioSourceNode();
}

extension JSMediaStreamAudioSourceNodeExtension
    on JSMediaStreamAudioSourceNode {
  external MediaStream get mediaStream;
}

class MediaStreamAudioSourceNode extends AudioNode {
  final JSMediaStreamAudioSourceNode _jsMediaStreamAudioSourceNode;

  MediaStreamAudioSourceNode(this._jsMediaStreamAudioSourceNode)
      : super(_jsMediaStreamAudioSourceNode);

  MediaStream get mediaStream => _jsMediaStreamAudioSourceNode.mediaStream;
}
