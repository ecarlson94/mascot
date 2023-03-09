import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/clean_architecture/entity.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/features/expressions/data/models/map_expression_to_expression_model.dart';
import 'package:mascot/features/expressions/data/models/map_image_to_image_model.dart';
import 'package:mascot/features/expressions/domain/entities/expression.dart';
import 'package:mascot/features/mascot/data/models/mascot_model.dart';
import 'package:mascot/features/mascot/data/models/map_mascot_to_mascot_model.dart';
import 'package:mascot/features/mascot/data/repositories/mascots_repository_impl.dart';
import 'package:mascot/features/mascot/domain/entities/mascot.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

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
      context.mocks.settingsRepository,
      mapMascotToMascotModel,
    );

    expressionIds = context.data.mascot.expressions.map((e) => e.id).toList();

    when(context.mocks.expressionsRepository.addExpressions(any))
        .thenAnswer((_) => Future.value(Right(expressionIds)));
    when(context.mocks.expressionsRepository.getExpressions(any)).thenAnswer(
      (_) => Future.value(
        Right(context.data.mascot.expressions),
      ),
    );
    when(context.mocks.mascotsLocalDataSource.getMascot(any))
        .thenAnswer((_) => Future.value(context.data.mascotModel));
  });

  group('MascotsRepositoryImpl', () {
    group('getMascot', () {
      test(
        'should return the requested mascot when call to local data source is successful',
        () async {
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

      test('should return failure when expression applicatian fails', () async {
        // arrange
        when(context.mocks.expressionsRepository.getExpressions(any))
            .thenThrow(Exception());

        // act
        final result = await repository.getMascot(context.data.mascot.id);

        // assert
        expect(result, Left(LocalDataSourceFailure()));
      });
    });

    group('addMascot', () {
      late List<Expression> emptyExpressions;
      late MascotModel mascotModelWithEmptyExpressions;

      setUp(() async {
        emptyExpressions = context.data.mascot.expressions
            .map((e) => Expression.empty.copyWith(id: e.id))
            .toList();
        mascotModelWithEmptyExpressions =
            await mapMascotToMascotModel(context.data.mascot.copyWith(
          expressions: emptyExpressions,
        ));

        when(context.mocks.mascotsLocalDataSource.addMascot(any))
            .thenAnswer((_) => Future.value(context.data.mascot.id));
        when(context.mocks.settingsRepository.loadSettings()).thenAnswer(
            (_) async =>
                Right(context.data.settings.copyWith(favoriteMascotId: 0)));
        when(context.mocks.settingsRepository.setFavoriteMascotId(any))
            .thenAnswer((_) => Future.value(const Right(unit)));
      });

      test(
        'should return the id of the added mascot when call to local data source is successful',
        () async {
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

      test('should update favorite mascot when adding a new mascot', () async {
        // act
        await repository.addMascot(context.data.mascot);

        // assert
        verify(context.mocks.settingsRepository.loadSettings());
        verify(context.mocks.settingsRepository.setFavoriteMascotId(
          context.data.mascot.id,
        ));
      });

      test(
        'should not update favorite mascot when favorite mascot is already set',
        () async {
          // arrange
          when(context.mocks.settingsRepository.loadSettings())
              .thenAnswer((_) async => Right(context.data.settings));

          // act
          await repository.addMascot(context.data.mascot);

          // assert
          verifyNever(context.mocks.settingsRepository.setFavoriteMascotId(
            context.data.mascot.id,
          ));
        },
      );
    });

    group('streamMascot', () {
      late BehaviorSubject<MascotModel?> modelStream;
      setUp(() {
        modelStream = BehaviorSubject<MascotModel>();

        when(context.mocks.mascotsLocalDataSource.getMascot(any))
            .thenAnswer((_) async => context.data.mascotModel);
        when(context.mocks.mascotsLocalDataSource.streamMascot(any))
            .thenAnswer((_) async => modelStream);
      });

      test('should seed the stream with the current value', () async {
        //act
        final result = await repository.streamMascot(context.data.mascot.id);

        // assert
        expect(result, isA<Right<Failure, Stream<Mascot?>>>());
        expect(
          result.getOrElse(() => const Stream.empty()),
          emitsInOrder([
            await mapMascotToMascotModel.reverse(context.data.mascotModel),
          ]),
        );
        verify(
          context.mocks.mascotsLocalDataSource
              .getMascot(context.data.mascot.id),
        );
        verify(
          context.mocks.mascotsLocalDataSource
              .streamMascot(context.data.mascot.id),
        );
        verifyNoMoreInteractions(context.mocks.mascotsLocalDataSource);
      });

      test(
        'should convert Stream<MascotModel?> to Stream<Mascot?>',
        () async {
          // arrange
          var updatedMascot = context.data.mascot.copyWith(
            name: 'updated',
          );
          var updatedMascotModel = await mapMascotToMascotModel(updatedMascot);

          // act
          final result = await repository.streamMascot(context.data.mascot.id);
          modelStream.add(updatedMascotModel);

          // assert
          expect(result, isA<Right<Failure, Stream<Mascot?>>>());
          expect(
            result.getOrElse(() => const Stream.empty()),
            emitsInOrder([
              await mapMascotToMascotModel.reverse(context.data.mascotModel),
              updatedMascot,
            ]),
          );
        },
      );

      test(
        'should retrieve expressions for mascot from expressions repository when a new mascot is received',
        () async {
          // arrange
          var mascotWithEmptyExpressions = context.data.mascot.copyWith(
            name: 'mascot model with empty expressions',
            expressions: context.data.mascot.expressions
                .map((e) => Expression.empty.copyWith(id: e.id))
                .toList(),
          );
          var mascotModelWithEmptyExpressions =
              await mapMascotToMascotModel(mascotWithEmptyExpressions);
          var expectedMascot = mascotWithEmptyExpressions.copyWith(
            expressions: context.data.expressions,
          );

          // act
          final result = await repository.streamMascot(context.data.mascot.id);
          modelStream.add(mascotModelWithEmptyExpressions);

          // assert
          await expectLater(
            result.getOrElse(() => const Stream.empty()),
            emitsInOrder([
              expectedMascot.copyWith(name: context.data.mascot.name),
              expectedMascot,
            ]),
          );
          verify(context.mocks.expressionsRepository.getExpressions(
            expressionIds,
          )).called(2);
        },
      );

      test(
        'should return failure when call to local data source is unsuccessful',
        () async {
          // arrange
          when(context.mocks.mascotsLocalDataSource.streamMascot(any))
              .thenThrow(Exception());

          // act
          final result = await repository.streamMascot(context.data.mascot.id);

          // assert
          expect(result, Left(LocalDataSourceFailure()));
        },
      );

      test('should return failure when expression applicatian fails', () async {
        // arrange
        when(context.mocks.expressionsRepository.getExpressions(any))
            .thenThrow(Exception());

        // act
        final result = await repository.streamMascot(context.data.mascot.id);

        // assert
        expect(result, Left(LocalDataSourceFailure()));
      });
    });
  });
}
