import 'dart:async';
import 'dart:typed_data';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart_ext/rxdart_ext.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../core/utils/logger.dart';
import '../../domain/models/camera_frame.dart';
import '../camera.dart';

@Injectable(as: Logger<WebCamera>)
class MascotCameraLogger extends Logger<WebCamera> {}

@LazySingleton(as: Camera)
class WebCamera implements Camera, Disposable {
  final Logger<WebCamera> _logger;
  final html.CanvasElement _canvasElement = html.CanvasElement();
  final html.VideoElement _videoElement = html.VideoElement();
  final StreamController<CameraFrame> _frameStreamController =
      StreamController.broadcast();

  Timer? _frameUpdateTimer;
  html.MediaStream? _cameraStream;

  WebCamera(this._logger);

  @override
  Single<bool> hasPermission() =>
      _setCameraStream().asSingle().map((_) => _cameraStream != null);

  @override
  Stream<CameraFrame> get cameraStream => _setCameraStream(throwOnError: true)
      .asSingle()
      .doOnData((_) => _startFrameUpdates())
      .switchMap((_) => _frameStreamController.stream);

  void _startFrameUpdates() async {
    if (_frameUpdateTimer != null) {
      return; // Timer already started
    }

    _frameUpdateTimer = Timer.periodic(
      const Duration(milliseconds: 33), // ~30fps
      (_) => _frameStreamController.add(getFrameData()),
    );
  }

  CameraFrame getFrameData() {
    html.CanvasRenderingContext2D context = _canvasElement.context2D;

    // Draw video frame to canvas
    context.drawImageScaledFromSource(
      _videoElement,
      0,
      0,
      _videoElement.videoWidth,
      _videoElement.videoHeight,
      0,
      0,
      _canvasElement.width ?? 0,
      _canvasElement.height ?? 0,
    );

    // Get image data from canvas
    final imageData = context.getImageData(
      0,
      0,
      _canvasElement.width ?? 0,
      _canvasElement.height ?? 0,
    );

    return CameraFrame(
      Uint8List.fromList(imageData.data),
      imageData.width,
      imageData.height,
    );
  }

  Future<void> _setCameraStream({bool throwOnError = false}) async {
    if (_cameraStream != null) {
      return; // Stream already set
    }

    try {
      _cameraStream ??= await html.window.navigator.mediaDevices?.getUserMedia({
        'video': true,
      });
    } catch (e) {
      var message = 'Error getting camera stream:';
      if (e is html.DomException && e.name == 'NotAllowedError') {
        message = 'Camera permission denied:';
      }

      _logger.logError(
        message,
        e,
      );

      if (throwOnError) rethrow;
    }

    if (throwOnError && _cameraStream == null) {
      var e = Exception('Failed to get camera stream');
      _logger.logError(e.toString(), e);
      throw e;
    }
  }

  @override
  FutureOr onDispose() {
    _frameStreamController.close();
    _frameUpdateTimer?.cancel();
    _frameUpdateTimer = null;
  }
}
