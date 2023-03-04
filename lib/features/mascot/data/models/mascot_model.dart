// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../domain/entities/mascot.dart';
import 'expression_model.dart';

part 'mascot_model.g.dart';

// ignore: todo
// TODO: uncomment when enabling Isar
// @Collection(
//   ignore: {'props', 'stringify'},
//   inheritance: false,
// )
@HiveType(typeId: 2)
class MascotModel extends Mascot {
  const MascotModel({
    required this.id,
    required this.name,
    this.expressions = const [],
  }) : super(
          id: id,
          name: name,
          expressions: expressions,
        );

  @HiveField(0)
  @override
  final Id id;

  @HiveField(1)
  @override
  final String name;

  @HiveField(2)
  @override
  final List<ExpressionModel> expressions;
}
