// ignore_for_file: overridden_fields

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../../../models/image_model.dart';

part 'hive_image.g.dart';

@HiveType(typeId: 0)
class HiveImage extends ImageModel {
  const HiveImage({required this.name, required this.data})
      : super(
          name: name,
          data: data,
        );

  @HiveField(1)
  @override
  final String name;

  @HiveField(2)
  @override
  final Uint8List data;
}
