import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/clean_architecture/entity.dart';
import 'package:mascot/core/data/drift/mascot_database.dart';
import 'package:mascot/features/expressions/data/datasources/drift/expressions_drift_data_source.dart';
import 'package:mascot/features/expressions/data/datasources/drift/models/drift_expression.dart';
import 'package:mascot/features/mascot/data/datasources/drift/mascots_drift_data_source.dart';
import 'package:mascot/features/mascot/data/datasources/drift/models/drift_mascot.dart';

import '../../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late MascotsDriftDataSource dataSource;
  late MascotDatabase database;
  late List<DriftExpression> expressionModels;
  late DriftMascot mascotModel;
  late List<Id> insertedIds;

  setUp(() {
    context = TestContext();
    database = context.database;
    dataSource = MascotsDriftDataSourceImpl(
      database,
      ExpressionsDriftDataSourceImpl(database),
    );
    insertedIds = context.data.expressions.map((e) => e.id).toList();
    expressionModels = context.data.expressions
        .map(context.data.mapExpressionToExpressionModel.map)
        .toList();
    mascotModel = context.data.mapMascotToMascotModel.map(context.data.mascot);
  });

  tearDown(() async {
    await database.close();
  });

  group('MascotsDriftDataSourceImpl', () {
    group('addMascot', () {
      test(
        'should insert mascot into mascots table',
        () async {
          // act
          await dataSource.addMascot(mascotModel);

          // assert
          var mascot = await database.select(database.mascots).getSingle();
          expect(mascot.id, equals(1));
          expect(mascot.name, equals(context.data.mascot.name));
        },
      );

      test(
        'should insert expressions into expressions table',
        () async {
          // act
          await dataSource.addMascot(mascotModel);

          // assert
          var expressions = await database.select(database.expressions).get();
          expect(expressions.length, equals(2));
          expect(
            expressions.map((e) => e.id),
            equals(insertedIds),
          );
          expect(
            expressions.map((e) => e.name),
            equals(expressionModels.map((e) => e.name)),
          );
          expect(
            expressions.map((e) => e.id),
            equals(expressionModels.map((e) => e.id)),
          );
        },
      );

      test(
        'should insert mascot expression maps into mascot expression maps table',
        () async {
          // act
          await dataSource.addMascot(mascotModel);

          // assert
          var maps = await database.select(database.mascotExpressionMaps).get();
          expect(maps.length, equals(2));
          expect(
            maps.map((e) => e.mascotId),
            equals([1, 1]),
          );
          expect(
            maps.map((e) => e.expressionId),
            equals(insertedIds),
          );
        },
      );

      test(
        'should return mascot id',
        () async {
          // act
          var id = await dataSource.addMascot(mascotModel);

          // assert
          expect(id, equals(1));
        },
      );

      test(
        'should update mascot if it already exists',
        () async {
          // arrange
          await dataSource.addMascot(mascotModel);
          var updatedMascot = context.data.mascot.copyWith(name: 'updated');

          // act
          await dataSource.addMascot(
            context.data.mapMascotToMascotModel.map(updatedMascot),
          );

          // assert
          var mascot = await database.select(database.mascots).getSingle();
          expect(mascot.id, equals(1));
          expect(mascot.name, equals(updatedMascot.name));
        },
      );

      test(
        'should update expressions if they already exist',
        () async {
          // arrange
          await dataSource.addMascot(mascotModel);
          var updatedExpressions = context.data.expressions
              .asMap()
              .entries
              .map((e) => e.value.copyWith(
                    name: 'updated ${e.key}',
                    description: 'updated ${e.key}',
                  ))
              .toSet();

          // act
          await dataSource.addMascot(
            context.data.mapMascotToMascotModel.map(
              context.data.mascot.copyWith(expressions: updatedExpressions),
            ),
          );

          // assert
          var expressions = await database.select(database.expressions).get();
          expect(expressions.length, equals(2));
          expect(
            expressions.map((e) => e.id),
            equals(insertedIds),
          );
          expect(
            expressions.map((e) => e.name),
            equals(updatedExpressions.map((e) => e.name)),
          );
          expect(
            expressions.map((e) => e.id),
            equals(updatedExpressions.map((e) => e.id)),
          );
          expect(
            expressions.map((e) => e.description),
            equals(updatedExpressions.map((e) => e.description)),
          );
        },
      );
    });

    group('getMascot', () {
      test(
        'should construct DriftMascot from mascots and expressions table',
        () async {
          // arrange
          await dataSource.addMascot(mascotModel);

          // act
          var result = await dataSource.getMascot(context.data.mascot.id);

          // assert
          expect(result, mascotModel);
        },
      );
    });

    group('streamMascot', () {
      test(
        'should emit DriftMascot with latest expressions when mascot is updated',
        () async {
          // arrange
          await dataSource.addMascot(mascotModel);
          var stream = dataSource.streamMascot(context.data.mascot.id);
          var updatedMascotModel = context.data.mapMascotToMascotModel
              .map(context.data.mascot.copyWith(name: 'updated'));

          // act
          await database.update(database.mascots).replace(updatedMascotModel);

          // assert
          await expectLater(
            stream,
            emitsInOrder([
              mascotModel,
              updatedMascotModel,
              updatedMascotModel,
            ]),
          );
        },
      );

      test(
        'should emit DriftMascot with latest mascot values when expression is updated',
        () async {
          // arrange
          await dataSource.addMascot(mascotModel);
          var stream = dataSource.streamMascot(context.data.mascot.id);
          var updatedExpressionModel = context
              .data.mapExpressionToExpressionModel
              .map(context.data.mascot.expressions.first
                  .copyWith(name: 'updated'));
          var updatedMascotModel = context.data.mapMascotToMascotModel.map(
            context.data.mascot.copyWith(
              expressions: {
                updatedExpressionModel,
                context.data.mascot.expressions.last,
              },
            ),
          );

          // act
          // await Future.delayed(const Duration(milliseconds: 100));
          await database
              .update(database.expressions)
              .replace(updatedExpressionModel);

          // assert
          await expectLater(
            stream,
            emits(updatedMascotModel),
          );
        },
      );

      test(
        'should emit DriftMascot with latest mascot values when expression is deleted',
        () async {
          // arrange
          await dataSource.addMascot(mascotModel);
          var stream = dataSource.streamMascot(context.data.mascot.id);
          var updatedMascotModel = context.data.mapMascotToMascotModel.map(
            context.data.mascot.copyWith(
              expressions: {
                context.data.mascot.expressions.last,
              },
            ),
          );

          // act
          await (database.delete(database.expressions)
                ..where((e) =>
                    e.id.equals(context.data.mascot.expressions.first.id)))
              .go();

          // assert
          await expectLater(
            stream,
            emits(updatedMascotModel),
          );
        },
      );

      test(
        'should emit DriftMascot with when expression map is added',
        () async {
          // arrange
          await dataSource.addMascot(mascotModel);
          var stream = dataSource.streamMascot(context.data.mascot.id);
          var newExpression = context.data.expression.copyWith(
            id: 3,
            name: 'new expression',
            description: 'new expression',
          );
          var updatedMascotModel = context.data.mapMascotToMascotModel.map(
            context.data.mascot.copyWith(
              expressions: {
                ...context.data.mascot.expressions,
                newExpression,
              },
            ),
          );

          // act
          await database.into(database.expressions).insert(
                context.data.mapExpressionToExpressionModel.map(
                  newExpression,
                ),
              );
          await database.into(database.mascotExpressionMaps).insert(
                MascotExpressionMapsCompanion(
                  mascotId: Value(context.data.mascot.id),
                  expressionId: Value(newExpression.id),
                ),
              );

          // assert
          await expectLater(
            stream,
            emitsInOrder([
              mascotModel,
              mascotModel,
              updatedMascotModel,
            ]),
          );
        },
      );

      test(
        'should emit DriftMascot with when expression map is deleted',
        () async {
          // arrange
          await dataSource.addMascot(mascotModel);
          var stream = dataSource.streamMascot(context.data.mascot.id);
          var updatedMascotModel = context.data.mapMascotToMascotModel.map(
            context.data.mascot.copyWith(
              expressions: {
                context.data.mascot.expressions.last,
              },
            ),
          );

          // act
          await (database.delete(database.mascotExpressionMaps)
                ..where((e) => e.expressionId
                    .equals(context.data.mascot.expressions.first.id)))
              .go();

          // assert
          await expectLater(stream, emits(updatedMascotModel));
        },
      );
    });
  });
}
