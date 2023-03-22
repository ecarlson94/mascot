import 'package:injectable/injectable.dart';

import 'js_interop/web_audio_js.dart';

@module
abstract class AudioContextModule {
  @lazySingleton
  AudioContext get audioContext => AudioContext();
}
