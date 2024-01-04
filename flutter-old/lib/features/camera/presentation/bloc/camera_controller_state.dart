part of 'camera_controller_bloc.dart';

abstract class CameraControllerState extends Equatable {
  final Option<CameraController> cameraControllerOption;

  const CameraControllerState(this.cameraControllerOption);

  @override
  List<Object> get props => [];
}

class CameraInitial extends CameraControllerState {
  CameraInitial() : super(none());
}

class CameraLoaded extends CameraControllerState {
  const CameraLoaded(super.cameraControllerOption);
}

class LoadCameraFailure extends CameraControllerState {
  final int errorCode;

  const LoadCameraFailure(this.errorCode, super.cameraControllerOption);
}
