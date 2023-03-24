@JS()
library static_interop;

import 'dart:typed_data';

import 'package:js/js.dart';

import 'audio_node.dart';

@JS('AnalyserNode')
@staticInterop
class JSAnalyserNode extends JSAudioNode {
  external factory JSAnalyserNode();
}

extension JSAnalyserNodeExtension on JSAnalyserNode {
  external void getFloatTimeDomainData(Float32List array);
  external int get frequencyBinCount;
}

class AnalyserNode extends AudioNode {
  final JSAnalyserNode _jsAnalyzerNode;

  AnalyserNode(this._jsAnalyzerNode) : super(_jsAnalyzerNode);

  void getFloatTimeDomainData(Float32List array) =>
      _jsAnalyzerNode.getFloatTimeDomainData(array);

  int get frequencyBinCount => _jsAnalyzerNode.frequencyBinCount;
}
