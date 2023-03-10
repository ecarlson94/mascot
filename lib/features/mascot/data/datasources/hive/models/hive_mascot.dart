// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';

import '../../../../../../core/clean_architecture/entity.dart';
import '../../../../../../core/data/hive/hive_model.dart';
import '../../../../../expressions/data/models/expression_model.dart';
import '../../../models/mascot_model.dart';

part 'hive_mascot.g.dart';

@HiveType(typeId: 2)
class HiveMascot extends MascotModel implements HiveModel {
  const HiveMascot({
    required this.id,
    required this.name,
    required List<ExpressionModel> expressions,
  })  : expressionsList = expressions,
        super(id: id, name: name, expressions: const {});

  @HiveField(0)
  @override
  final Id id;

  @HiveField(1)
  @override
  final String name;

  @HiveField(2)
  final List<ExpressionModel> expressionsList;

  @override
  Set<ExpressionModel> get expressions => expressionsList.toSet();

  @override
  HiveMascot copyWithId(Id id) {
    return HiveMascot(
      id: id,
      name: name,
      expressions: expressionsList,
    );
  }
}
