import 'dart:async';

import 'package:camera/camera.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../core/utils/logger.dart';
import '../../domain/services/camera_controller_context.dart';
import '../../domain/services/camera_controller_factory.dart';
import '../../domain/services/camera_service.dart';

@Injectable(as: Logger<CameraControllerContextImpl>)
class CameraControllerContextImplLogger
    extends Logger<CameraControllerContextImpl> {}

@Injectable(as: CameraControllerContext)
class CameraControllerContextImpl
    implements CameraControllerContext, Disposable {
  final CameraService _cameraService;
  final CameraControllerFactory _cameraControllerFactory;
  final Logger<CameraControllerContextImpl> _logger;

  CameraController? _cameraController;

  CameraControllerContextImpl(
    this._cameraService,
    this._cameraControllerFactory,
    this._logger,
  );

  @override
  Single<CameraController> getController({
    CameraDescription? cameraDesc,
    ResolutionPreset resolutionPreset = ResolutionPreset.medium,
  }) =>
      _getCameraDesc(cameraDesc).switchMapSingle(
        (camera) => Single.fromCallable(() async {
          _cameraController ??= _cameraControllerFactory.createController(
            cameraDesc: camera,
            resolutionPreset: resolutionPreset,
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
          ? _cameraService.cameras.map((cameras) => cameras.first)
          : Single.value(cameraDesc);
}
