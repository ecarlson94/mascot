// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';

import '../../../../../../core/clean_architecture/entity.dart';
import '../../../../../../core/data/hive/hive_model.dart';
import '../../../models/expression_model.dart';
import 'hive_image.dart';

part 'hive_expression.g.dart';

@HiveType(typeId: 3)
class HiveExpression extends ExpressionModel
    implements HiveModel<HiveExpression> {
  const HiveExpression({
    required this.id,
    required this.name,
    required this.description,
    required this.imageModel,
  }) : super(
          id: id,
          name: name,
          description: description,
          image: imageModel,
        );

  @HiveField(0)
  @override
  final Id id;

  @HiveField(1)
  @override
  final String name;

  @HiveField(2)
  @override
  final String description;

  @HiveField(3)
  @override
  final HiveImage imageModel;

  @override
  HiveExpression copyWithId(Id id) {
    return HiveExpression(
      id: id,
      name: name,
      description: description,
      imageModel: imageModel,
    );
  }
}
