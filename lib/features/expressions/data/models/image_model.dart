import '../../domain/entities/image.dart';

abstract class ImageModel extends Image {
  const ImageModel({required super.name, required super.data});
}
