import 'package:flutter/foundation.dart';

import '../../../../core/clean_architecture/entity.dart';

class Image extends EquatableEntity {
  final String name;
  final Uint8List data;

  const Image({super.id, required this.name, required this.data});

  @override
  List<Object?> get props => [id, name];
}
