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
      context.mocks.imageCollectionAdapter,
    );
  });

  group('getImage', () {
    test('should return ImageModel from local database', () async {
      // arrange
      when(context.mocks.imageCollectionAdapter.get(any))
          .thenAnswer((_) async => context.data.imageModel);

      // act
      final result = await dataSource.getImage(1);

      // assert
      expect(result, context.data.imageModel);
      verify(context.mocks.imageCollectionAdapter.get(1));
      verifyNoMoreInteractions(context.mocks.imageCollectionAdapter);
    });
  });

  group('addImage', () {
    test(
      'should return new image id from local database after adding image to database',
      () async {
        // arrange
        var id = 1;
        when(context.mocks.imageCollectionAdapter.add(any))
            .thenAnswer((_) async => id);

        // act
        final result = await dataSource.addImage(context.data.imageModel);

        // assert
        expect(result, equals(id));
        verify(
            context.mocks.imageCollectionAdapter.add(context.data.imageModel));
        verifyNoMoreInteractions(context.mocks.imageCollectionAdapter);
      },
    );
  });
}
