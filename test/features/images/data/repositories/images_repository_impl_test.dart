import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/clean_architecture/entity.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/features/images/data/models/image_model.dart';
import 'package:mascot/features/images/data/repositories/images_repository_impl.dart';
import 'package:mascot/features/images/data/repositories/map_image_to_image_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late ImagesRepositoryImpl repository;

  setUp(() {
    context = TestContext();
    repository = ImagesRepositoryImpl(
      context.mocks.imagesLocalDataSource,
      MapImageToImageModel(),
    );
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
      });
    });

    group('addImages', () {
      test(
        'should return new image ids when call to local data source is successful',
        () async {
          // arrange
          var ids = context.data.images.map((e) => e.id).toList();
          when(context.mocks.imagesLocalDataSource.addImage(any)).thenAnswer(
            (_) async => (_.positionalArguments[0] as ImageModel).id,
          );

          // act
          final result = await repository.addImages(context.data.images);

          // assert
          expect(result, isA<Right<Failure, List<Id>>>());
          expect(ids, equals(result.getOrElse(() => [])));
          for (var imageModel in context.data.imageModels) {
            verify(context.mocks.imagesLocalDataSource.addImage(imageModel));
          }
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
          final result = await repository.addImages(context.data.images);

          // assert
          expect(result, Left(LocalDataSourceFailure()));
        },
      );

      test(
        'should remove successful images when call to local data source is unsuccessful',
        () async {
          // arrange
          var imageModel1 = context.data.imageModels.first;
          var imageModel2 = context.data.imageModels.skip(1).first;
          when(context.mocks.imagesLocalDataSource.addImage(imageModel1))
              .thenAnswer(
            (_) async => (_.positionalArguments[0] as ImageModel).id,
          );
          when(context.mocks.imagesLocalDataSource.addImage(imageModel2))
              .thenThrow(Exception());
          when(context.mocks.imagesLocalDataSource.removeImage(any))
              .thenAnswer((_) async {});

          // act
          await repository.addImages(context.data.images);

          // assert
          verify(
            context.mocks.imagesLocalDataSource.removeImage(imageModel1.id),
          );
        },
      );
    });

    group('getImages', () {
      test(
        'should return all images when call to local data source is successful',
        () async {
          // arrange
          var ids = context.data.images.map((e) => e.id).toList();
          when(context.mocks.imagesLocalDataSource.getImages(any))
              .thenAnswer((_) => Future.value(context.data.imageModels));

          // act
          final result = await repository.getImages(ids);

          // assert
          expect(result, Right(context.data.imageModels));
          verify(context.mocks.imagesLocalDataSource.getImages(ids));
          verifyNoMoreInteractions(context.mocks.imagesLocalDataSource);
        },
      );

      test(
          'should return failure when call to local data source is unsuccessful',
          () async {
        // arrange
        when(context.mocks.imagesLocalDataSource.getImages(any))
            .thenThrow(Exception());

        // act
        final result = await repository.getImages([]);

        // assert
        expect(result, Left(LocalDataSourceFailure()));
      });
    });
  });
}
