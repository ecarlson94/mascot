import 'package:mascot/features/images/domain/repositories/images_repository.dart';
import 'package:mockito/annotations.dart';
import './mocks.mocks.dart';

@GenerateMocks([ImagesRepository])
class Mocks {
  MockImagesRepository? _mockImagesRepository;
  MockImagesRepository get mockImagesRepository =>
      _mockImagesRepository ??= MockImagesRepository();
}
