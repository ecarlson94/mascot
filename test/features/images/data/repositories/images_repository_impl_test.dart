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
    repository = ImagesRepositoryImpl(
      context.mocks.imagesLocalDataSource,
      context.mocks.mapImageToImageModel,
    );
    when(context.mocks.mapImageToImageModel(any))
        .thenAnswer((_) => context.data.imageModel);
  });

  group('ImagesRepositoryImpl', () {
    group('getImage', () {
      test(
        'should return the requested image when call to local data source is successful',
        () async {
          // arrange
          when(context.mocks.imagesLocalDataSource.getImage(any))
              .thenAnswer((_) => Future.value(context.data.imageModel));

          // act
          final result = await repository.getImage(context.data.image.id);

          // assert
          expect(result, Right(context.data.imageModel));

          verify(context.mocks.imagesLocalDataSource
              .getImage(context.data.image.id));
          verifyNoMoreInteractions(context.mocks.imagesLocalDataSource);
        },
      );

      test(
          'should return failure when call to local data source is unsuccessful',
          () async {
        // arrange
        when(context.mocks.imagesLocalDataSource.getImage(any))
            .thenThrow(Exception());

        // act
        final result = await repository.getImage(context.data.image.id);

        // assert
        expect(result, Left(LocalDataSourceFailure()));

        verify(context.mocks.imagesLocalDataSource
            .getImage(context.data.image.id));
        verifyNoMoreInteractions(context.mocks.imagesLocalDataSource);
      });
    });

    group('addImage', () {
      test(
        'should return new image id when call to local data source is successful',
        () async {
          // arrange
          when(context.mocks.imagesLocalDataSource.addImage(any))
              .thenAnswer((_) async => context.data.imageModel.id);

          // act
          final result = await repository.addImage(context.data.image);

          // assert
          expect(result, Right(context.data.imageModel.id));
          verify(context.mocks.imagesLocalDataSource
              .addImage(context.data.imageModel));
          verifyNoMoreInteractions(context.mocks.imagesLocalDataSource);
        },
      );

      test(
          'should return failure when call to local data source is unsuccessful',
          () async {
        // arrange
        when(context.mocks.imagesLocalDataSource.addImage(any))
            .thenThrow(Exception());

        // act
        final result = await repository.addImage(context.data.image);

        // assert
        expect(result, Left(LocalDataSourceFailure()));

        verify(context.mocks.imagesLocalDataSource
            .addImage(context.data.imageModel));
        verifyNoMoreInteractions(context.mocks.imagesLocalDataSource);
      });
    });
  });
}
