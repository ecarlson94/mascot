import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/features/mascot/data/repositories/map_expression_to_expression_model.dart';
import 'package:mascot/features/mascot/data/repositories/map_mascot_to_mascot_model.dart';
import 'package:mascot/features/mascot/data/repositories/mascots_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late MascotsRepositoryImpl repository;
  setUp(() {
    context = TestContext();
    repository = MascotsRepositoryImpl(
      context.mocks.mascotsLocalDataSource,
      context.mocks.imagesRepository,
      MapMascotToMascotModel(MapExpressionToExpressionModel()),
    );
  });

  group('MascotsRepositoryImpl', () {
    group('getMascot', () {
      test(
        'should return the requested mascot when call to local data source is successful',
        () async {
          // arrange
          when(context.mocks.mascotsLocalDataSource.getMascot(any))
              .thenAnswer((_) => Future.value(context.data.mascotModel));

          // act
          final result = await repository.getMascot(context.data.mascot.id);

          // assert
          expect(result, Right(context.data.mascotModel));

          verify(context.mocks.mascotsLocalDataSource
              .getMascot(context.data.mascot.id));
          verifyNoMoreInteractions(context.mocks.mascotsLocalDataSource);
        },
      );

      test(
        'should return failure when call to local data source is unsuccessful',
        () async {
          // arrange
          when(context.mocks.mascotsLocalDataSource.getMascot(any))
              .thenThrow(Exception());

          // act
          final result = await repository.getMascot(context.data.mascot.id);

          // assert
          expect(result, Left(LocalDataSourceFailure()));

          verify(context.mocks.mascotsLocalDataSource
              .getMascot(context.data.mascot.id));
          verifyNoMoreInteractions(context.mocks.mascotsLocalDataSource);
        },
      );
    });

    group('addMascot', () {
      test(
        'should return the id of the added mascot when call to local data source is successful',
        () async {
          // arrange
          when(context.mocks.mascotsLocalDataSource.addMascot(any))
              .thenAnswer((_) => Future.value(context.data.mascot.id));

          // act
          final result = await repository.addMascot(context.data.mascot);

          // assert
          expect(result, Right(context.data.mascot.id));

          verify(
            context.mocks.mascotsLocalDataSource
                .addMascot(context.data.mascotModel),
          );
          verifyNoMoreInteractions(context.mocks.mascotsLocalDataSource);
        },
      );

      test(
        'should return failure when call to local data source is unsuccessful',
        () async {
          // arrange
          when(context.mocks.mascotsLocalDataSource.addMascot(any))
              .thenThrow(Exception());

          // act
          final result = await repository.addMascot(context.data.mascot);

          // assert
          expect(result, Left(LocalDataSourceFailure()));

          verify(
            context.mocks.mascotsLocalDataSource
                .addMascot(context.data.mascotModel),
          );
          verifyNoMoreInteractions(context.mocks.mascotsLocalDataSource);
        },
      );
    });
  });
}
