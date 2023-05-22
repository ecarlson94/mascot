import 'package:camera/camera.dart';

abstract class CameraControllerFactory {
  CameraController createController({
    required CameraDescription cameraDesc,
    ResolutionPreset resolutionPreset = ResolutionPreset.medium,
  });
}
