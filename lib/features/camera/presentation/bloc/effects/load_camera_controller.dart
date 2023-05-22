import 'dart:async';

import 'package:camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:mascot/features/camera/presentation/bloc/camera_controller_bloc.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../../core/error/error.dart';
import '../../../../../core/reactive/base_bloc.dart';
import '../../../../../core/utils/logger.dart';
import '../../../domain/services/camera_context.dart';

@Injectable(as: Logger<LoadCameraController>)
class LoadCameraLogger extends Logger<LoadCameraController> {}

@injectable
class LoadCameraController extends BlocEffect<CameraControllerEvent,
    InitializeCameraEvent, CameraControllerState> {
  final CameraContext _cameraContext;
  final Logger<LoadCameraController> _logger;

  LoadCameraController(this._cameraContext, this._logger);

  @override
  Stream<CameraControllerEvent> call(
    InitializeCameraEvent event,
    CameraControllerState state,
  ) {
    var single = _cameraContext
        .getController()
        .map<CameraControllerEvent>(
          (cameraController) => CameraLoadedEvent(cameraController),
        )
        .onErrorReturnWith(_mapErrorToFailureEvent);

    return single;
  }

  LoadCameraFailureEvent _mapErrorToFailureEvent(
    Object error,
    StackTrace stackTrace,
  ) {
    String message = 'Failed to load camera';
    LoadCameraFailureEvent failureEvent = const LoadCameraFailureEvent(
      ErrorCodes.unknownFailure,
    );

    if (error is CameraException) {
      message = error.description ?? message;
      switch (error.code) {
        case 'CameraAccessDenied':
          failureEvent = const LoadCameraFailureEvent(
            ErrorCodes.cameraPermissionFailure,
          );
          break;
        default:
          failureEvent = const LoadCameraFailureEvent(
            ErrorCodes.cameraRetrievalFailure,
          );
          break;
      }
    }

    _logger.logError(message, error, stackTrace);

    return failureEvent;
  }
}
