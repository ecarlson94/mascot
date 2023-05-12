import 'package:rxdart_ext/rxdart_ext.dart';

import '../domain/models/camera_frame.dart';

abstract class Camera {
  Single<bool> hasPermission();
  Stream<CameraFrame> get cameraStream;
}
