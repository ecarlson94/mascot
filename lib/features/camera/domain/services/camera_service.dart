import 'package:camera/camera.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

abstract class CameraService {
  Single<List<CameraDescription>> get cameras;
}
