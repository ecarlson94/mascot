@JS()
library static_interop;

import 'dart:typed_data';

import 'package:js/js.dart';

import 'audio_node.dart';

@JS('AnalyserNode')
@staticInterop
class JSAnalyzerNode extends JSAudioNode {
  external factory JSAnalyzerNode();
}

extension JSAnalyzerNodeExtension on JSAnalyzerNode {
  external void getFloatTimeDomainData(Float32List array);
  external int get frequencyBinCount;
}

class AnalyzerNode extends AudioNode {
  final JSAnalyzerNode _jsAnalyzerNode;

  AnalyzerNode(this._jsAnalyzerNode) : super(_jsAnalyzerNode);

  void getFloatTimeDomainData(Float32List array) =>
      _jsAnalyzerNode.getFloatTimeDomainData(array);

  int get frequencyBinCount => _jsAnalyzerNode.frequencyBinCount;
}
