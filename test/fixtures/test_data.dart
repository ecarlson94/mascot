import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:mascot/features/images/data/models/image_model.dart';
import 'package:mascot/features/images/domain/entities/image.dart';
import 'package:mascot/features/mascot/data/models/expression_model.dart';
import 'package:mascot/features/mascot/data/models/mascot_model.dart';
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

  final List<ImageModel> imageModels = [
    ImageModel(
      id: 3,
      name: 'test1',
      data: Uint8List(200),
    ),
    ImageModel(
      id: 4,
      name: 'test2',
      data: Uint8List(200),
    ),
  ];
  List<Image> get images => imageModels;

  XFile? _xfile;
  XFile get xfile => _xfile ??= TestXFile.fromData(
        image.data,
        name: image.name,
      );

  final MascotModel mascotModel = MascotModel(
    id: 1,
    name: 'test',
    expressions: [
      ExpressionModel(
        name: 'neutral',
        description: 'this expression is neutral',
        image: Image(
          id: 1,
          name: 'neutralFace',
          data: Uint8List(200),
        ),
      ),
      ExpressionModel(
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
  Mascot get mascot => mascotModel;
}
