import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';

import '../../domain/services/camera_controller_factory.dart';

@Injectable(as: CameraControllerFactory)
class CameraControllerFactoryImpl extends CameraControllerFactory {
  @override
  CameraController createController({
    required CameraDescription cameraDesc,
    ResolutionPreset resolutionPreset = ResolutionPreset.medium,
  }) =>
      CameraController(cameraDesc, resolutionPreset);
}
