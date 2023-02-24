import 'package:isar/isar.dart';
import 'package:mascot/features/images/data/datasources/images_local_data_source.dart';
import 'package:mascot/features/images/data/models/image_model.dart';
import 'package:mascot/features/images/domain/repositories/images_repository.dart';
import 'package:mockito/annotations.dart';
import './mocks.mocks.dart';

@GenerateMocks([
  ImagesRepository,
  ImagesLocalDataSource,
  IsarCollection<ImageModel>,
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
}
