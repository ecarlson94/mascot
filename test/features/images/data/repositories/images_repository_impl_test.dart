import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/features/images/data/repositories/images_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late ImagesRepositoryImpl repository;

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
            .thenAnswer((_) => Future.value(context.data.imageModel));

        // act
        final result = await repository.getImage(context.data.image.id);

        // assert
        expect(result, Right(context.data.image));

        verify(context.mocks.mockImagesLocalDataSource
            .getImage(context.data.image.id));
        verifyNoMoreInteractions(context.mocks.mockImagesLocalDataSource);
      },
    );

    test('should return failure when call to local data source is unsuccessful',
        () async {
      // arrange
      when(context.mocks.mockImagesLocalDataSource.getImage(any))
          .thenThrow(Exception());

      // act
      final result = await repository.getImage(context.data.image.id);

      // assert
      expect(result, Left(LocalDataSourceFailure()));

      verify(context.mocks.mockImagesLocalDataSource
          .getImage(context.data.image.id));
      verifyNoMoreInteractions(context.mocks.mockImagesLocalDataSource);
    });
  });

  group('saveImage', () {
    test(
      'should should return saved image when call to local data source is successful',
      () async {
        // arrange
        when(context.mocks.mockImagesLocalDataSource.saveImage(any))
            .thenAnswer((_) async => context.data.imageModel);

        // act
        final result = await repository.saveImage(context.data.image);

        // assert
        expect(result, Right(context.data.image));

        verify(context.mocks.mockImagesLocalDataSource
            .saveImage(context.data.imageModel));
        verifyNoMoreInteractions(context.mocks.mockImagesLocalDataSource);
      },
    );

    test('should return failure when call to local data source is unsuccessful',
        () async {
      // arrange
      when(context.mocks.mockImagesLocalDataSource.saveImage(any))
          .thenThrow(Exception());

      // act
      final result = await repository.saveImage(context.data.image);

      // assert
      expect(result, Left(LocalDataSourceFailure()));

      verify(context.mocks.mockImagesLocalDataSource
          .saveImage(context.data.imageModel));
      verifyNoMoreInteractions(context.mocks.mockImagesLocalDataSource);
    });
  });
}
