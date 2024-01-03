import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'camera_controller_provider.dart';

class CameraVideo extends StatelessWidget {
  final double width;

  const CameraVideo({super.key, this.width = 400});

  @override
  Widget build(BuildContext context) {
    return CameraControllerProvider(
      builder: (context, controller) => SizedBox(
        width: width,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Card(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            child: CameraPreview(controller),
          ),
        ),
      ),
    );
  }
}
