import 'package:image_picker/image_picker.dart';
import 'package:mascot/features/images/data/models/image_model.dart';
import 'package:mascot/features/images/domain/entities/image.dart';

class TestData {
  final ImageModel imageModel = const ImageModel(id: 1, name: 'test');
  Image get image => imageModel;

  XFile? _xfile;
  XFile get xfile => _xfile ??= XFile('test');
}
