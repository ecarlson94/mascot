import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class TestXFile extends XFile {
  Uint8List _bytes = Uint8List(0);

  TestXFile(super.path);

  @override
  Future<Uint8List> readAsBytes() async => _bytes;

  @override
  String name = 'valid';

  TestXFile.fromData(
    this._bytes, {
    String? mimeType,
    this.name = 'valid',
    int? length,
    DateTime? lastModified,
    String? path,
  }) : super.fromData(_bytes);
}
