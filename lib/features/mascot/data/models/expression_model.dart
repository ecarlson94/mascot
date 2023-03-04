// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';

import '../../../images/domain/entities/image.dart';
import '../../domain/entities/expression.dart';

part 'expression_model.g.dart';

// ignore: todo
// TODO: uncomment when enabling Isar
// @Embedded(
//   ignore: {'props', 'stringify'},
//   inheritance: false
// )
@HiveType(typeId: 3)
class ExpressionModel extends Expression {
  const ExpressionModel({
    required this.name,
    required this.description,
    required this.image,
  }) : super(name: name, description: description, image: image);

  @HiveField(0)
  @override
  final String name;

  @HiveField(1)
  @override
  final String description;

  @HiveField(2)
  @override
  final Image image;
}
