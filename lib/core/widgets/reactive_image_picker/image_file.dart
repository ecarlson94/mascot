import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_file.freezed.dart';

@freezed
class ImageFile with _$ImageFile {
  const ImageFile._();

  const factory ImageFile({
    Uint8List? bytes,
  }) = _ImageFile;

  bool get isEmpty => bytes == null;

  bool get isNotEmpty => !isEmpty;
}
