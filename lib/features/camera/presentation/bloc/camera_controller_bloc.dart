import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/reactive/base_bloc.dart';
import 'effects/load_camera_controller.dart';

part 'camera_controller_event.dart';
part 'camera_controller_state.dart';

@injectable
class CameraControllerBloc
    extends BaseBloc<CameraControllerEvent, CameraControllerState> {
  final LoadCameraController _loadCamera;

  CameraControllerBloc(this._loadCamera) : super(CameraInitial()) {
    createEffect(_loadCamera);
    createAction<CameraLoadedEvent>(
      (event, state) => CameraLoaded(some(event.cameraController)),
    );
    createAction<LoadCameraFailureEvent>((event, state) =>
        LoadCameraFailure(event.errorCode, state.cameraControllerOption));
  }
}
