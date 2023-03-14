import '../../domain/entities/expression.dart';
import 'image_model.dart';

abstract class ExpressionModel extends Expression {
  const ExpressionModel({
    required super.id,
    required super.name,
    required super.description,
    required ImageModel image,
  })  : imageModel = image,
        super(image: image);

  final ImageModel imageModel;
  @override
  ImageModel get image => imageModel;
}
