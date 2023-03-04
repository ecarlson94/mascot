import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:mascot/features/expressions/data/models/expression_model.dart';
import 'package:mascot/features/expressions/data/models/image_model.dart';
import 'package:mascot/features/expressions/domain/entities/expression.dart';
import 'package:mascot/features/expressions/domain/entities/image.dart';
import 'package:mascot/features/mascot/data/models/mascot_model.dart';
import 'package:mascot/features/mascot/domain/entities/mascot.dart';

import 'test_x_file.dart';

class TestData {
  final ImageModel imageModel = ImageModel(name: 'test', data: Uint8List(200));
  Image get image => Image(
        name: imageModel.name,
        data: imageModel.data,
      );

  final List<ImageModel> imageModels = [
    ImageModel(
      name: 'test1',
      data: Uint8List(200),
    ),
    ImageModel(
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

  final ExpressionModel expressionModel = ExpressionModel(
    id: 1,
    name: 'neutral',
    description: 'this expression is neutral',
    image: ImageModel(
      name: 'neutralFace',
      data: Uint8List(200),
    ),
  );
  Expression get expression => expressionModel;

  final List<ExpressionModel> expressionModels = [
    ExpressionModel(
      id: 1,
      name: 'neutral',
      description: 'this expression is neutral',
      image: ImageModel(
        name: 'neutralFace',
        data: Uint8List(200),
      ),
    ),
    ExpressionModel(
      id: 2,
      name: 'talking',
      description: 'this expression is talking',
      image: ImageModel(
        name: 'talkingFace',
        data: Uint8List(200),
      ),
    ),
  ];
  List<Expression> get expressions => expressionModels;

  final MascotModel mascotModel = MascotModel(
    id: 1,
    name: 'test',
    expressions: [
      ExpressionModel(
        id: 1,
        name: 'neutral',
        description: 'this expression is neutral',
        image: ImageModel(
          name: 'neutralFace',
          data: Uint8List(200),
        ),
      ),
      ExpressionModel(
        id: 2,
        name: 'talking',
        description: 'this expression is talking',
        image: ImageModel(
          name: 'talkingFace',
          data: Uint8List(200),
        ),
      ),
    ],
  );
  Mascot get mascot => mascotModel;
}
