import 'package:injectable/injectable.dart';

import 'js_interop/web_audio_js.dart';

@LazySingleton()
class WebAudio {
  AudioContext? _context;
  AudioContext get context => _context ??= AudioContext()..resume();

  @disposeMethod
  void dispose() {
    _context?.close();
  }
}
