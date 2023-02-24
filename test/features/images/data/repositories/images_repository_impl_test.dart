import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/features/images/data/models/image_model.dart';
import 'package:mascot/features/images/data/repositories/images_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late ImagesRepositoryImpl repository;
  const tImage = ImageModel(isarId: 1);

  setUp(() {
    context = TestContext();
    repository = ImagesRepositoryImpl(context.mocks.mockImagesLocalDataSource);
  });

  group('getImage', () {
    test(
      'should return the requested image when call to local data source is successful',
      () async {
        // arrange
        when(context.mocks.mockImagesLocalDataSource.getImage(any))
            .thenAnswer((_) async => tImage);

        // act
        final result = await repository.getImage(tImage.id);

        // assert
        expect(result, const Right(tImage));

        verify(context.mocks.mockImagesLocalDataSource.getImage(tImage.id));
        verifyNoMoreInteractions(context.mocks.mockImagesLocalDataSource);
      },
    );

    test('should return failure when call to local data source is unsuccessful',
        () async {
      // arrange
      when(context.mocks.mockImagesLocalDataSource.getImage(any))
          .thenThrow(Exception());

      // act
      final result = await repository.getImage(tImage.id);

      // assert
      expect(result, Left(LocalDataSourceFailure()));

      verify(context.mocks.mockImagesLocalDataSource.getImage(tImage.id));
      verifyNoMoreInteractions(context.mocks.mockImagesLocalDataSource);
    });
  });

  group('saveImage', () {
    test(
      'should should return saved image when call to local data source is successful',
      () async {
        // arrange
        when(context.mocks.mockImagesLocalDataSource.saveImage(any))
            .thenAnswer((_) async => tImage);

        // act
        final result = await repository.saveImage(tImage);

        // assert
        expect(result, const Right(tImage));

        verify(context.mocks.mockImagesLocalDataSource.saveImage(tImage));
        verifyNoMoreInteractions(context.mocks.mockImagesLocalDataSource);
      },
    );

    test('should return failure when call to local data source is unsuccessful',
        () async {
      // arrange
      when(context.mocks.mockImagesLocalDataSource.saveImage(any))
          .thenThrow(Exception());

      // act
      final result = await repository.saveImage(tImage);

      // assert
      expect(result, Left(LocalDataSourceFailure()));

      verify(context.mocks.mockImagesLocalDataSource.saveImage(tImage));
      verifyNoMoreInteractions(context.mocks.mockImagesLocalDataSource);
    });
  });
}
