import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class CameraFrame extends Equatable {
  final Uint8List data;
  final int width;
  final int height;

  const CameraFrame(this.data, this.width, this.height);

  @override
  List<Object?> get props => [data, width, height];
}
