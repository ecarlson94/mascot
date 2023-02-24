import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/images/data/datasources/images_local_data_source.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late ImagesLocalDataSourceImpl dataSource;

  setUp(() {
    context = TestContext();
    dataSource = ImagesLocalDataSourceImpl(
      context.mocks.mockImageModelCollection,
    );
  });

  group('getImage', () {
    test('should return ImageModel from local database', () async {
      // arrange
      when(context.mocks.mockImageModelCollection.get(any))
          .thenAnswer((_) async => context.data.imageModel);

      // act
      final result = await dataSource.getImage(1);

      // assert
      expect(result, context.data.imageModel);
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
            .thenAnswer((_) async => context.data.imageModel);

        // act
        final result = await dataSource.saveImage(context.data.imageModel);

        // assert
        expect(result, context.data.imageModel);
        verifyInOrder([
          context.mocks.mockImageModelCollection.put(context.data.imageModel),
          context.mocks.mockImageModelCollection.get(1),
        ]);
        verifyNoMoreInteractions(context.mocks.mockImageModelCollection);
      },
    );
  });
}
