// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../domain/entities/expression.dart';
import 'image_model.dart';

part 'expression_model.g.dart';

// ignore: todo
// TODO: uncomment when enabling Isar
// @Collection(
//   ignore: {'props', 'stringify'},
//   inheritance: false
// )
@HiveType(typeId: 3)
class ExpressionModel extends Expression {
  const ExpressionModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  }) : super(
          id: id,
          name: name,
          description: description,
          image: image,
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
  final ImageModel image;
}
