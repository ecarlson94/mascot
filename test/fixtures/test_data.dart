import 'dart:typed_data';

import 'package:mascot/features/expressions/data/datasources/drift/models/drift_expression_mapper.dart';
import 'package:mascot/features/expressions/domain/entities/expression.dart';
import 'package:mascot/features/mascot/data/datasources/drift/models/drift_mascot_mapper.dart';
import 'package:mascot/features/mascot/domain/entities/mascot.dart';
import 'package:mascot/features/mascot/presentation/bloc/create_mascot_bloc.dart';
import 'package:mascot/features/settings/data/datasources/drift/models/drift_settings_mapper.dart';
import 'package:mascot/features/settings/domain/entities/settings.dart';

import 'test_x_file.dart';

class TestData {
  TestXFile? _xfile;
  TestXFile get xfile => _xfile ??= TestXFile.fromData(
        Uint8List(5),
        name: 'test',
      );

  final Expression expression = Expression(
    id: 1,
    name: CreateMascotBloc.neutralExpressionName,
    description: CreateMascotBloc.neutralExpressionDescription,
    image: Uint8List(5),
  );
  final DriftExpressionMapperImpl driftExpressionMapper =
      DriftExpressionMapperImpl();

  final List<Expression> expressions = [
    Expression(
      id: 1,
      name: CreateMascotBloc.neutralExpressionName,
      description: CreateMascotBloc.neutralExpressionDescription,
      image: Uint8List(5),
    ),
    Expression(
      id: 2,
      name: CreateMascotBloc.talkingExpressionName,
      description: CreateMascotBloc.talkingExpressionDescription,
      image: Uint8List(5),
    ),
  ];

  final Mascot mascot = Mascot(
    id: 1,
    name: 'test',
    expressions: {
      Expression(
        id: 1,
        name: CreateMascotBloc.neutralExpressionName,
        description: CreateMascotBloc.neutralExpressionDescription,
        image: Uint8List(5),
      ),
      Expression(
        id: 2,
        name: CreateMascotBloc.talkingExpressionName,
        description: CreateMascotBloc.talkingExpressionDescription,
        image: Uint8List(5),
      ),
    },
  );
  final DriftMascotMapperImpl driftMascotMapper = DriftMascotMapperImpl();

  final Settings settings = const Settings(favoriteMascotId: 1);
  final DriftSettingsMapperImpl driftSettingsMapper = DriftSettingsMapperImpl();
}
