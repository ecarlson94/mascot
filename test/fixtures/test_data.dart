import 'package:mascot/features/images/data/models/image_model.dart';
import 'package:mascot/features/images/domain/entities/image.dart';

class TestData {
  final ImageModel imageModel = const ImageModel(isarId: 1, name: 'test');
  Image get image => imageModel;
}
