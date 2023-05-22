import 'package:camera/camera.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

abstract class CameraContext {
  Single<List<CameraDescription>> get cameras;
  Single<CameraController> getController({
    CameraDescription? cameraDesc,
    ResolutionPreset resolutionPreset = ResolutionPreset.medium,
  });
}
