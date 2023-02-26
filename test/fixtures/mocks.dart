import 'package:hive/hive.dart';
import 'package:isar/isar.dart' as isar;
import 'package:mascot/core/utils/input_converters/convert_xfile_to_image.dart';
import 'package:mascot/core/utils/mappers/map_image_to_image_model.dart';
import 'package:mascot/features/images/data/datasources/images_collection.dart';
import 'package:mascot/features/images/data/datasources/images_local_data_source.dart';
import 'package:mascot/features/images/domain/repositories/images_repository.dart';
import 'package:mascot/features/images/domain/usecases/get_image.dart';
import 'package:mascot/features/images/domain/usecases/save_image.dart';
import 'package:mockito/annotations.dart';

import 'mocks.mocks.dart';
import 'test_model.dart';

@GenerateMocks([
  ImagesRepository,
  ImagesLocalDataSource,
  isar.IsarCollection<TestModel>,
  CollectionBox<TestModel>,
  LocalImages,
  ConvertXfileToImage,
  MapImageToImageModel,
  GetImage,
  SaveImage,
])
class Mocks {
  MockImagesRepository? _imagesRepository;
  MockImagesRepository get imagesRepository =>
      _imagesRepository ??= MockImagesRepository();

  MockImagesLocalDataSource? _imagesLocalDataSource;
  MockImagesLocalDataSource get imagesLocalDataSource =>
      _imagesLocalDataSource ??= MockImagesLocalDataSource();

  MockIsarCollection<TestModel>? _isarTestCollection;
  MockIsarCollection<TestModel> get isarTestCollection =>
      _isarTestCollection ??= MockIsarCollection();

  MockCollectionBox<TestModel>? _hiveTestCollection;
  MockCollectionBox<TestModel> get hiveTestCollection =>
      _hiveTestCollection ??= MockCollectionBox();

  MockLocalImages? _mockLocalImages;
  MockLocalImages get mockLocalImages => _mockLocalImages ??= MockLocalImages();

  MockConvertXfileToImage? _convertXfileToImage;
  MockConvertXfileToImage get convertXfileToImage =>
      _convertXfileToImage ??= MockConvertXfileToImage();

  MockMapImageToImageModel? _mapImageToImageModel;
  MockMapImageToImageModel get mapImageToImageModel =>
      _mapImageToImageModel ??= MockMapImageToImageModel();

  MockGetImage? _getImage;
  MockGetImage get getImage => _getImage ??= MockGetImage();

  MockSaveImage? _saveImage;
  MockSaveImage get saveImage => _saveImage ??= MockSaveImage();
}
