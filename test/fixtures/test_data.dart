import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:mascot/features/images/data/models/image_model.dart';
import 'package:mascot/features/images/domain/entities/image.dart';
import 'package:mascot/features/mascot/domain/entities/expression.dart';
import 'package:mascot/features/mascot/domain/entities/mascot.dart';

import 'test_x_file.dart';

class TestData {
  final ImageModel imageModel =
      ImageModel(id: 1, name: 'test', data: Uint8List(200));
  Image get image => Image(
        id: imageModel.id,
        name: imageModel.name,
        data: imageModel.data,
      );

  XFile? _xfile;
  XFile get xfile => _xfile ??= TestXFile.fromData(
        image.data,
        name: image.name,
      );

  final Mascot mascot = Mascot(
    id: 1,
    name: 'test',
    expressions: [
      Expression(
        name: 'neutral',
        description: 'this expression is neutral',
        image: Image(
          id: 1,
          name: 'neutralFace',
          data: Uint8List(200),
        ),
      ),
      Expression(
        name: 'talking',
        description: 'this expression is talking',
        image: Image(
          id: 2,
          name: 'talkingFace',
          data: Uint8List(200),
        ),
      ),
    ],
  );
}
