import 'package:hive/hive.dart';
import 'package:isar/isar.dart' as isar;
import 'package:isar/isar.dart';
import 'package:mascot/core/data/collection_adapter.dart';
import 'package:mascot/core/utils/input_converters/convert_xfile_to_image.dart';
import 'package:mascot/core/utils/mappers/map_image_to_image_model.dart';
import 'package:mascot/features/images/data/datasources/images_local_data_source.dart';
import 'package:mascot/features/images/data/models/image_model.dart';
import 'package:mascot/features/images/domain/repositories/images_repository.dart';
import 'package:mascot/features/images/domain/usecases/get_image.dart';
import 'package:mascot/features/images/domain/usecases/save_image.dart';
import 'package:mascot/features/mascot/domain/repositories/mascots_repository.dart';
import 'package:mockito/annotations.dart';

import 'mocks.mocks.dart';
import 'test_model.dart';

@GenerateNiceMocks([
  MockSpec<Isar>(unsupportedMembers: {#txnSync, #writeTxnSync}),
  MockSpec<CollectionAdapter<ImageModel>>(as: #MockImagesCollectionAdapter),
])
@GenerateMocks([
  ImagesRepository,
  ImagesLocalDataSource,
  isar.IsarCollection<TestModel>,
  Box<TestModel>,
  HiveInterface,
  ConvertXfileToImage,
  MapImageToImageModel,
  GetImage,
  SaveImage,
  MascotsRepository,
])
class Mocks {
  MockIsar? _isar;
  MockIsar get isar => _isar ??= MockIsar();

  MockImagesRepository? _imagesRepository;
  MockImagesRepository get imagesRepository =>
      _imagesRepository ??= MockImagesRepository();

  MockImagesLocalDataSource? _imagesLocalDataSource;
  MockImagesLocalDataSource get imagesLocalDataSource =>
      _imagesLocalDataSource ??= MockImagesLocalDataSource();

  MockIsarCollection<TestModel>? _isarTestCollection;
  MockIsarCollection<TestModel> get isarTestCollection =>
      _isarTestCollection ??= MockIsarCollection();

  MockBox<TestModel>? _hiveTestCollection;
  MockBox<TestModel> get hiveTestCollection =>
      _hiveTestCollection ??= MockBox();

  MockBox<ImageModel>? _hiveImageBox;
  MockBox<ImageModel> get hiveImageBox => _hiveImageBox ??= MockBox();

  MockImagesCollectionAdapter? _imageCollectionAdapter;
  MockImagesCollectionAdapter get imageCollectionAdapter =>
      _imageCollectionAdapter ??= MockImagesCollectionAdapter();

  MockHiveInterface? _hiveInterface;
  MockHiveInterface get hiveInterface => _hiveInterface ??= MockHiveInterface();

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

  MockMascotsRepository? _mascotsRepository;
  MockMascotsRepository get mascotsRepository =>
      _mascotsRepository ??= MockMascotsRepository();
}
