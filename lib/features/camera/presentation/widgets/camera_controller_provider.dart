import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascot/core/extensions/extensions.dart';

import '../../../../core/injection/injection_container.dart';
import '../bloc/camera_controller_bloc.dart';

class CameraControllerProvider extends StatelessWidget {
  final Widget Function(BuildContext, CameraController) builder;

  const CameraControllerProvider({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CameraControllerBloc>(
      create: (_) => getIt<CameraControllerBloc>(),
      child: BlocBuilder<CameraControllerBloc, CameraControllerState>(
        builder: (context, state) {
          if (state is CameraInitial) {
            context.bloc<CameraControllerBloc>().add(InitializeCameraEvent());
          }

          return state.cameraControllerOption.fold(
            () => const SizedBox.shrink(),
            (cameraController) => builder(context, cameraController),
          );
        },
      ),
    );
  }
}
