// ignore: todo
// TODO: remove when enabling Isar
// ignore_for_file: overridden_fields

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../domain/entities/image.dart';

part 'image_model.g.dart';

// ignore: todo
// TODO: uncomment when enabling Isar
// @Collection(
//   ignore: {'props', 'stringify'},
//   inheritance: false,
// )
@HiveType(typeId: 0)
class ImageModel extends Image {
  const ImageModel({this.id, required this.name, required this.data})
      : super(
          id: id,
          name: name,
          data: data,
        );

  @HiveField(0)
  @override
  final Id? id;

  @HiveField(1)
  @override
  final String name;

  @HiveField(2)
  @override
  final Uint8List data;
}
