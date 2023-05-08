import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_file.freezed.dart';

@freezed
class ImageFile with _$ImageFile {
  const ImageFile._();

  const factory ImageFile({
    required Uint8List bytes,
  }) = _ImageFile;

  bool get isEmpty => bytes.isEmpty;

  bool get isNotEmpty => !isEmpty;
}
