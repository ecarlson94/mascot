part of 'camera_controller_bloc.dart';

abstract class CameraControllerEvent extends Equatable {
  const CameraControllerEvent();

  @override
  List<Object> get props => [];
}

class InitializeCameraEvent extends CameraControllerEvent {}

class LoadCameraFailureEvent extends CameraControllerEvent {
  final int errorCode;

  const LoadCameraFailureEvent(this.errorCode);

  @override
  List<Object> get props => [errorCode];
}

class CameraLoadedEvent extends CameraControllerEvent {
  final CameraController cameraController;

  const CameraLoadedEvent(this.cameraController);

  @override
  List<Object> get props => [cameraController];
}
