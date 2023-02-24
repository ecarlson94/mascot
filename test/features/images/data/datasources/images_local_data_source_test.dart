import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/images/data/datasources/images_local_data_source.dart';
import 'package:mascot/features/images/data/models/image_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late ImagesLocalDataSourceImpl dataSource;
  late ImageModel tImageModel;

  setUp(() {
    context = TestContext();
    dataSource = ImagesLocalDataSourceImpl(
      context.mocks.mockImageModelCollection,
    );

    tImageModel = const ImageModel(isarId: 1);
  });

  group('getImage', () {
    test('should return ImageModel from local database', () async {
      // arrange
      when(context.mocks.mockImageModelCollection.get(any))
          .thenAnswer((_) async => tImageModel);

      // act
      final result = await dataSource.getImage(1);

      // assert
      expect(result, tImageModel);
      verify(context.mocks.mockImageModelCollection.get(1));
      verifyNoMoreInteractions(context.mocks.mockImageModelCollection);
    });

    test('should throw Exception when image is not found', () async {
      // arrange
      when(context.mocks.mockImageModelCollection.get(any))
          .thenAnswer((_) async => null);

      // act
      final call = dataSource.getImage;

      // assert
      expect(() => call(1), throwsException);
    });
  });

  group('saveImage', () {
    test(
      'should return ImageModel from local database after saving image to database',
      () async {
        // arrange
        when(context.mocks.mockImageModelCollection.put(any))
            .thenAnswer((_) async => 1);
        when(context.mocks.mockImageModelCollection.get(any))
            .thenAnswer((_) async => tImageModel);

        // act
        final result = await dataSource.saveImage(tImageModel);

        // assert
        expect(result, tImageModel);
        verifyInOrder([
          context.mocks.mockImageModelCollection.put(tImageModel),
          context.mocks.mockImageModelCollection.get(1),
        ]);
        verifyNoMoreInteractions(context.mocks.mockImageModelCollection);
      },
    );
  });
}
