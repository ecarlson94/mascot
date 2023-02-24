import 'package:isar/isar.dart';
import 'package:mascot/core/utils/input_converters/convert_xfile_to_image.dart';
import 'package:mascot/features/images/data/datasources/images_local_data_source.dart';
import 'package:mascot/features/images/data/models/image_model.dart';
import 'package:mascot/features/images/domain/repositories/images_repository.dart';
import 'package:mascot/features/images/domain/usecases/get_image.dart';
import 'package:mascot/features/images/domain/usecases/save_image.dart';
import 'package:mockito/annotations.dart';
import './mocks.mocks.dart';

@GenerateMocks([
  ImagesRepository,
  ImagesLocalDataSource,
  IsarCollection<ImageModel>,
  ConvertXfileToImage,
  GetImage,
  SaveImage,
])
class Mocks {
  MockImagesRepository? _mockImagesRepository;
  MockImagesRepository get mockImagesRepository =>
      _mockImagesRepository ??= MockImagesRepository();

  MockImagesLocalDataSource? _mockImagesLocalDataSource;
  MockImagesLocalDataSource get mockImagesLocalDataSource =>
      _mockImagesLocalDataSource ??= MockImagesLocalDataSource();

  MockIsarCollection<ImageModel>? _mockImageModelCollection;
  MockIsarCollection<ImageModel> get mockImageModelCollection =>
      _mockImageModelCollection ??= MockIsarCollection<ImageModel>();

  MockConvertXfileToImage? _mockConvertXfileToImage;
  MockConvertXfileToImage get mockConvertXfileToImage =>
      _mockConvertXfileToImage ??= MockConvertXfileToImage();

  MockGetImage? _mockGetImage;
  MockGetImage get mockGetImage => _mockGetImage ??= MockGetImage();

  MockSaveImage? _mockSaveImage;
  MockSaveImage get mockSaveImage => _mockSaveImage ??= MockSaveImage();
}
