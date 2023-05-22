import 'dart:async';

import 'package:camera/camera.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../core/utils/logger.dart';
import '../../domain/services/camera_context.dart';

@Injectable(as: Logger<CameraContextImpl>)
class CameraContextImplLogger extends Logger<CameraContextImpl> {}

@LazySingleton(as: CameraContext)
class CameraContextImpl implements CameraContext, Disposable {
  final Logger<CameraContextImpl> _logger;

  List<CameraDescription>? _cameras;
  CameraController? _cameraController;

  CameraContextImpl(this._logger);

  @override
  Single<List<CameraDescription>> get cameras => Single.fromCallable(() async {
        _cameras ??= await availableCameras();
        return _cameras!;
      }).doOnError(
        (e, s) => _logger.logError('Failed to get cameras', e, s),
      );

  @override
  Single<CameraController> getController({
    CameraDescription? cameraDesc,
    ResolutionPreset resolutionPreset = ResolutionPreset.medium,
  }) =>
      _getCameraDesc(cameraDesc).switchMapSingle(
        (camera) => Single.fromCallable(() async {
          _cameraController ??= CameraController(
            camera,
            resolutionPreset,
          );

          if (!_cameraController!.value.isInitialized) {
            await _cameraController!.initialize();
          }

          return _cameraController!;
        }).doOnError(
          (e, s) => _logger.logError('Failed to get camera controller', e, s),
        ),
      );

  @override
  FutureOr onDispose() {
    _cameraController?.dispose();
  }

  Single<CameraDescription> _getCameraDesc(CameraDescription? cameraDesc) =>
      cameraDesc == null
          ? cameras.map((cameras) => cameras.first)
          : Single.value(cameraDesc);
}
