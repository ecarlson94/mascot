import 'dart:typed_data';

import 'package:mascot/features/expressions/data/datasources/hive/models/hive_expression.dart';
import 'package:mascot/features/expressions/data/datasources/hive/models/hive_image.dart';
import 'package:mascot/features/expressions/data/datasources/hive/models/map_expression_to_hive_expression.dart';
import 'package:mascot/features/expressions/data/datasources/hive/models/map_image_to_hive_image.dart';
import 'package:mascot/features/expressions/domain/entities/expression.dart';
import 'package:mascot/features/expressions/domain/entities/image.dart';
import 'package:mascot/features/mascot/data/datasources/hive/models/hive_mascot.dart';
import 'package:mascot/features/mascot/data/datasources/hive/models/map_mascot_to_hive_mascot.dart';
import 'package:mascot/features/mascot/domain/entities/mascot.dart';
import 'package:mascot/features/mascot/presentation/bloc/create_mascot_bloc.dart';
import 'package:mascot/features/settings/data/datasources/hive/models/hive_settings.dart';
import 'package:mascot/features/settings/data/datasources/hive/models/map_settings_to_hive_settings.dart';
import 'package:mascot/features/settings/domain/entities/settings.dart';

import 'test_x_file.dart';

class TestData {
  Image get image => Image(
        name: 'test',
        data: Uint8List(200),
      );
  final MapImageToHiveImage mapImageToHiveImage = MapImageToHiveImage();
  HiveImage get hiveImage => mapImageToHiveImage.map(image);

  final List<Image> images = [
    Image(
      name: 'test1',
      data: Uint8List(200),
    ),
    Image(
      name: 'test2',
      data: Uint8List(200),
    ),
  ];
  List<HiveImage> get hiveImages =>
      images.map(mapImageToHiveImage.map).toList();

  TestXFile? _xfile;
  TestXFile get xfile => _xfile ??= TestXFile.fromData(
        image.data,
        name: image.name,
      );

  final Expression expression = Expression(
    id: 1,
    name: CreateMascotBloc.neutralExpressionName,
    description: CreateMascotBloc.neutralExpressionDescription,
    image: Image(
      name: 'test',
      data: Uint8List(200),
    ),
  );
  final MapExpressionToHiveExpression mapExpressionToHiveExpression =
      MapExpressionToHiveExpression(MapImageToHiveImage());
  HiveExpression get hiveExpression =>
      mapExpressionToHiveExpression.map(expression);

  final List<Expression> expressions = [
    Expression(
      id: 1,
      name: CreateMascotBloc.neutralExpressionName,
      description: CreateMascotBloc.neutralExpressionDescription,
      image: Image(
        name: 'neutralFace',
        data: Uint8List(200),
      ),
    ),
    Expression(
      id: 2,
      name: CreateMascotBloc.talkingExpressionName,
      description: CreateMascotBloc.talkingExpressionDescription,
      image: Image(
        name: 'talkingFace',
        data: Uint8List(200),
      ),
    ),
  ];
  List<HiveExpression> get hiveExpressions =>
      expressions.map(mapExpressionToHiveExpression.map).toList();

  final Mascot mascot = Mascot(
    id: 1,
    name: 'test',
    expressions: {
      Expression(
        id: 1,
        name: CreateMascotBloc.neutralExpressionName,
        description: CreateMascotBloc.neutralExpressionDescription,
        image: Image(
          name: 'neutralFace',
          data: Uint8List(200),
        ),
      ),
      Expression(
        id: 2,
        name: CreateMascotBloc.talkingExpressionName,
        description: CreateMascotBloc.talkingExpressionDescription,
        image: Image(
          name: 'talkingFace',
          data: Uint8List(200),
        ),
      ),
    },
  );
  final MapMascotToHiveMascot mapMascotToHiveMascot = MapMascotToHiveMascot(
    MapExpressionToHiveExpression(MapImageToHiveImage()),
  );
  HiveMascot get mascotModel => mapMascotToHiveMascot.map(mascot);

  final Settings settings = const Settings(favoriteMascotId: 1);
  final MapSettingsToHiveSettings mapSettingsToHiveSettings =
      MapSettingsToHiveSettings();
  HiveSettings get hiveSettings => mapSettingsToHiveSettings.map(settings);
}
