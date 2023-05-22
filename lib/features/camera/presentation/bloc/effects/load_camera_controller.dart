import 'dart:async';

import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:mascot/features/camera/presentation/bloc/camera_controller_bloc.dart';

import '../../../../../core/error/error.dart';
import '../../../../../core/reactive/base_bloc.dart';
import '../../../../../core/utils/logger.dart';

@Injectable(as: Logger<LoadCameraController>)
class LoadCameraLogger extends Logger<LoadCameraController> {}

@LazySingleton()
class LoadCameraController extends BlocEffect<CameraControllerEvent,
    InitializeCameraEvent, CameraControllerState> {
  final Logger<LoadCameraController> _logger;

  List<CameraDescription>? _cameras;
  CameraController? _cameraController;

  LoadCameraController(this._logger);

  @override
  Stream<CameraControllerEvent> call(
    InitializeCameraEvent event,
    CameraControllerState state,
  ) async* {
    if (_cameraController != null) {
      yield CameraLoadedEvent(_cameraController!);
      return;
    }

    try {
      // TODO: create camera service for getting cameras, use RX
      _cameras ??= await availableCameras();

      if (_cameras!.isEmpty) {
        _logger.logError('No cameras found');
        yield const LoadCameraFailureEvent(ErrorCodes.noCamerasFailure);
      } else {
        _cameraController ??= CameraController(
          _cameras![0],
          ResolutionPreset.medium,
        );

        // TODO: create camera service for returning camera controller, use RX
        // TODO: create camera context for managing camera controller lifecycle, use RX,
        //       should wrap `availableCameras` and `CameraController`
        yield* _initializeController();
      }
    } on CameraException catch (e) {
      _logger.logError('Error retrieving cameras', e);
      yield const LoadCameraFailureEvent(ErrorCodes.cameraRetrievalFailure);
    }
  }

  Stream<CameraControllerEvent> _initializeController() async* {
    try {
      if (!(_cameraController?.value.isInitialized ?? false)) {
        await _cameraController!.initialize();
      }
      yield CameraLoadedEvent(_cameraController!);
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          _logger.logError('Camera access denied', e);
          yield const LoadCameraFailureEvent(
            ErrorCodes.cameraPermissionFailure,
          );
          break;
        default:
          _logger.logError('Error initializing camera', e);
          yield const LoadCameraFailureEvent(ErrorCodes.unknownFailure);
          break;
      }
    }
  }

  @override
  FutureOr onDispose() async {
    await _cameraController?.dispose();
    return super.onDispose();
  }
}
