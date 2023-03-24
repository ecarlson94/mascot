import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/clean_architecture/entity.dart';
import 'package:mascot/core/data/drift/mascot_database.dart';
import 'package:mascot/features/expressions/data/datasources/drift/expressions_drift_data_source.dart';
import 'package:mascot/features/mascot/data/datasources/drift/mascots_drift_data_source.dart';
import 'package:mascot/features/mascot/data/datasources/drift/models/drift_mascot.dart';

import '../../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late MascotDatabase database;
  late MascotsDriftDataSource classUnderTest;
  late ExpressionsDriftDataSource expressionsDriftDataSource;

  late DriftMascot mascotModel;
  late List<Id> insertedExpressionIds;

  setUp(() async {
    context = TestContext();
    database = context.database;
    expressionsDriftDataSource = ExpressionsDriftDataSourceImpl(database);
    classUnderTest = MascotsDriftDataSourceImpl(
      database,
    );

    insertedExpressionIds = context.data.expressions.map((e) => e.id).toList();
    mascotModel =
        context.data.driftMascotMapper.fromMascot(context.data.mascot);
  });

  Future<void> insertMascotAndExpressions(DriftMascot mascotModel) async {
    await classUnderTest.upsertMascot(mascotModel);
    await expressionsDriftDataSource.upsertExpressions(mascotModel.expressions);
  }

  tearDown(() async {
    await database.close();
  });

  group('MascotsDriftDataSourceImpl', () {
    group('addMascot', () {
      test(
        'should insert mascot into mascots table',
        () async {
          // act
          await insertMascotAndExpressions(mascotModel);

          // assert
          var mascot = await classUnderTest.getMascot(mascotModel.id);
          expect(mascot, equals(mascotModel));
        },
      );

      test(
        'should not insert expressions into expressions table',
        () async {
          // act
          await classUnderTest.upsertMascot(mascotModel);

          // assert
          var expressions = await database.select(database.expressions).get();
          expect(expressions.length, equals(0));
        },
      );

      test(
        'should insert mascot expression maps into mascot expression maps table',
        () async {
          // act
          await insertMascotAndExpressions(mascotModel);

          // assert
          var maps = await database.select(database.mascotExpressionMaps).get();
          expect(maps.length, equals(2));
          expect(
            maps.map((e) => e.mascotId),
            equals([1, 1]),
          );
          expect(
            maps.map((e) => e.expressionId),
            equals(insertedExpressionIds),
          );
        },
      );

      test(
        'should return mascot id',
        () async {
          // act
          var id = await classUnderTest.upsertMascot(mascotModel);

          // assert
          expect(id, equals(1));
        },
      );

      test(
        'should auto-increment mascot id',
        () async {
          // arrange
          await insertMascotAndExpressions(mascotModel);
          var mascotModel2 = context.data.driftMascotMapper.fromMascot(
            context.data.mascot.copyWith(id: 0, name: 'mascot 2'),
          );

          // act
          var id = await classUnderTest.upsertMascot(mascotModel2);

          // assert
          expect(id, equals(2));
        },
      );

      test(
        'should update mascot if it already exists',
        () async {
          // arrange
          await insertMascotAndExpressions(mascotModel);
          var mascotModel2 = context.data.driftMascotMapper.fromMascot(
            context.data.mascot.copyWith(id: 2, name: 'new guy'),
          );
          await classUnderTest.upsertMascot(mascotModel2);
          var updatedMascot = context.data.mascot.copyWith(name: 'updated');

          // act
          var id = await classUnderTest.upsertMascot(
            context.data.driftMascotMapper.fromMascot(updatedMascot),
          );

          // assert
          expect(id, equals(1));
          var mascot = await (database.select(database.mascots)
                ..where((m) => m.id.equals(1)))
              .getSingle();
          expect(mascot.name, equals(updatedMascot.name));
        },
      );
    });

    group('getMascot', () {
      test(
        'should construct DriftMascot from mascots and expressions table',
        () async {
          // arrange
          await insertMascotAndExpressions(mascotModel);

          // act
          var result = await classUnderTest.getMascot(context.data.mascot.id);

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
          await insertMascotAndExpressions(mascotModel);
          var stream = classUnderTest.streamMascot(context.data.mascot.id);
          var updatedMascotModel = context.data.driftMascotMapper
              .fromMascot(context.data.mascot.copyWith(name: 'updated'));

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
          await insertMascotAndExpressions(mascotModel);
          var stream = classUnderTest.streamMascot(context.data.mascot.id);
          var updatedExpressionModel = context.data.driftExpressionMapper
              .fromExpression(context.data.mascot.expressions.first
                  .copyWith(name: 'updated'));
          var updatedMascotModel = context.data.driftMascotMapper.fromMascot(
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
          await insertMascotAndExpressions(mascotModel);
          var stream = classUnderTest.streamMascot(context.data.mascot.id);
          var updatedMascotModel = context.data.driftMascotMapper.fromMascot(
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
          await insertMascotAndExpressions(mascotModel);
          var stream = classUnderTest.streamMascot(context.data.mascot.id);
          var newExpression = context.data.expression.copyWith(
            id: 3,
            name: 'new expression',
            description: 'new expression',
          );
          var updatedMascotModel = context.data.driftMascotMapper.fromMascot(
            context.data.mascot.copyWith(
              expressions: {
                ...context.data.mascot.expressions,
                newExpression,
              },
            ),
          );

          // act
          await database.into(database.expressions).insert(
                context.data.driftExpressionMapper.fromExpression(
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
          await insertMascotAndExpressions(mascotModel);
          var stream = classUnderTest.streamMascot(context.data.mascot.id);
          var updatedMascotModel = context.data.driftMascotMapper.fromMascot(
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
