// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';

import '../../../../../../core/clean_architecture/entity.dart';
import '../../../../../../core/data/hive/hive_model.dart';
import '../../../../../expressions/data/datasources/hive/models/hive_expression.dart';
import '../../../models/mascot_model.dart';

part 'hive_mascot.g.dart';

@HiveType(typeId: 2)
class HiveMascot extends MascotModel implements HiveModel<HiveMascot> {
  const HiveMascot({
    required this.id,
    required this.name,
    required this.expressionModels,
  }) : super(
          id: id,
          name: name,
          expressionModels: expressionModels,
        );

  @HiveField(0)
  @override
  final Id id;

  @HiveField(1)
  @override
  final String name;

  @HiveField(2)
  @override
  final List<HiveExpression> expressionModels;

  @override
  Set<HiveExpression> get expressions => expressionModels.toSet();

  @override
  HiveMascot copyWithId(Id id) {
    return HiveMascot(
      id: id,
      name: name,
      expressionModels: expressionModels,
    );
  }
}
