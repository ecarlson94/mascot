import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/clean_architecture/entity.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/features/expressions/data/repositories/map_expression_to_expression_model.dart';
import 'package:mascot/features/expressions/data/repositories/map_image_to_image_model.dart';
import 'package:mascot/features/expressions/domain/entities/expression.dart';
import 'package:mascot/features/mascot/data/models/mascot_model.dart';
import 'package:mascot/features/mascot/data/repositories/map_mascot_to_mascot_model.dart';
import 'package:mascot/features/mascot/data/repositories/mascots_repository_impl.dart';
import 'package:mascot/features/mascot/domain/entities/mascot.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late MascotsRepositoryImpl repository;
  late MapMascotToMascotModel mapMascotToMascotModel;
  late List<Id> expressionIds;

  setUp(() {
    context = TestContext();
    mapMascotToMascotModel = MapMascotToMascotModel(
      MapExpressionToExpressionModel(MapImageToImageModel()),
    );
    repository = MascotsRepositoryImpl(
      context.mocks.mascotsLocalDataSource,
      context.mocks.expressionsRepository,
      mapMascotToMascotModel,
    );

    expressionIds = context.data.mascot.expressions.map((e) => e.id).toList();

    when(context.mocks.expressionsRepository.addExpressions(any))
        .thenAnswer((_) => Future.value(Right(expressionIds)));
    when(context.mocks.expressionsRepository.getExpressions(any))
        .thenAnswer((_) => Future.value(
              Right(context.data.mascot.expressions),
            ));
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
          expect(
            result,
            Right<Failure, Mascot>(context.data.mascot.copyWith()),
          );

          verify(context.mocks.mascotsLocalDataSource
              .getMascot(context.data.mascot.id));
          verifyNoMoreInteractions(context.mocks.mascotsLocalDataSource);
        },
      );

      test(
        'should convert MascotModel to Mascot',
        () async {
          // arrange
          when(context.mocks.mascotsLocalDataSource.getMascot(any))
              .thenAnswer((_) => Future.value(context.data.mascotModel));

          // act
          var result = await repository.getMascot(context.data.mascot.id);

          // assert
          expect(
            result.getOrElse(() => Mascot.empty),
            isNot(isA<MascotModel>()),
          );
        },
      );

      test('should retrieve expressions for mascot from expressions repository',
          () async {
        // arrange
        when(context.mocks.mascotsLocalDataSource.getMascot(any))
            .thenAnswer((_) => Future.value(context.data.mascotModel));

        // act
        await repository.getMascot(context.data.mascot.id);

        // assert
        verify(
          context.mocks.expressionsRepository.getExpressions(expressionIds),
        );
      });

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
      late List<Expression> emptyExpressions;
      late MascotModel mascotModelWithEmptyExpressions;

      setUp(() {
        emptyExpressions = context.data.mascot.expressions
            .map((e) => Expression.empty.copyWith(id: e.id))
            .toList();
        mascotModelWithEmptyExpressions =
            mapMascotToMascotModel(context.data.mascot.copyWith(
          expressions: emptyExpressions,
        ));
      });

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
            context.mocks.mascotsLocalDataSource.addMascot(
              mascotModelWithEmptyExpressions,
            ),
          );
          verifyNoMoreInteractions(context.mocks.mascotsLocalDataSource);
        },
      );

      test(
        'should add expressions to expressions repository',
        () async {
          // arrange
          when(context.mocks.mascotsLocalDataSource.addMascot(any))
              .thenAnswer((_) => Future.value(context.data.mascot.id));

          // act
          final result = await repository.addMascot(context.data.mascot);

          // assert
          expect(result, Right(context.data.mascot.id));
          verify(context.mocks.expressionsRepository.addExpressions(
            context.data.mascot.expressions,
          ));
          verify(context.mocks.expressionsRepository.getExpressions(
            expressionIds,
          ));
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
                .addMascot(mascotModelWithEmptyExpressions),
          );
          verifyNoMoreInteractions(context.mocks.mascotsLocalDataSource);
        },
      );
    });
  });
}
