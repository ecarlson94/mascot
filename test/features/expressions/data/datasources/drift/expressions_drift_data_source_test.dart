import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/data/drift/mascot_database.dart';
import 'package:mascot/features/expressions/data/datasources/drift/expressions_drift_data_source.dart';
import 'package:mascot/features/expressions/data/datasources/drift/models/drift_expression.dart';

import '../../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late MascotDatabase database;
  late ExpressionsDriftDataSource classUnderTest;

  late List<DriftExpression> expressionModels;
  late DriftExpression expressionModel;

  setUp(() {
    context = TestContext();
    database = context.database;
    classUnderTest = ExpressionsDriftDataSourceImpl(database);

    expressionModels = context.data.expressions
        .map(context.data.mapExpressionToExpressionModel.map)
        .toList();
    expressionModel = context.data.mapExpressionToExpressionModel.map(
      context.data.expressions.first,
    );
  });

  group('ExpressionsDriftDataSourceImpl', () {
    group('upsertExpression', () {
      test(
        'should insert an expression',
        () async {
          // act
          var id = await classUnderTest.upsertExpression(expressionModel);

          // assert
          expect(id, equals(1));
          var expression =
              await database.select(database.expressions).getSingle();
          expect(expression, equals(expressionModel));
        },
      );

      test(
        'should auto-increment the id',
        () async {
          // arrange
          await classUnderTest.upsertExpression(expressionModel);
          var expressionModel2 = DriftExpression(
            id: 0,
            name: 'test',
            description: 'test',
            image: Uint8List(5),
          );

          // act
          var id = await classUnderTest.upsertExpression(expressionModel2);

          // assert
          expect(id, equals(2));
        },
      );

      test(
        'should update an expression',
        () async {
          // arrange
          await classUnderTest.upsertExpressions(expressionModels);
          var expressionModel2 = DriftExpression(
            id: 1,
            name: 'test',
            description: 'test',
            image: Uint8List(5),
          );

          // act
          var id = await classUnderTest.upsertExpression(expressionModel2);

          // assert
          expect(id, equals(1));
          var expression = await (database.select(database.expressions)
                ..where((e) => e.id.equals(1)))
              .getSingle();
          expect(expression, equals(expressionModel2));
        },
      );
    });

    group('upsertExpressions', () {
      test(
        'should insert expressions',
        () async {
          // act
          var ids = await classUnderTest.upsertExpressions(expressionModels);

          // assert
          expect(ids, equals(expressionModels.map((e) => e.id).toList()));
          var expressions = await database.select(database.expressions).get();
          expect(expressions, equals(expressionModels));
        },
      );

      test(
        'should update expressions',
        () async {
          // arrange
          await classUnderTest.upsertExpressions(expressionModels);
          var expressionModels2 = expressionModels.map((e) {
            return DriftExpression(
              id: e.id,
              name: 'test ${e.id}',
              description: 'test ${e.id}',
              image: Uint8List(5),
            );
          }).toList();

          // act
          var ids = await classUnderTest.upsertExpressions(expressionModels2);

          // assert
          expect(ids, equals(expressionModels2.map((e) => e.id).toList()));
          var expressions = await database.select(database.expressions).get();
          expect(expressions, equals(expressionModels2));
        },
      );

      test(
        'should return the ids of the expressions',
        () async {
          // act
          var ids = await classUnderTest.upsertExpressions(expressionModels);

          // assert
          expect(ids, equals(expressionModels.map((e) => e.id).toList()));
        },
      );
    });

    group('removeExpression', () {
      test(
        'should remove an expression',
        () async {
          // arrange
          await classUnderTest.upsertExpressions(expressionModels);

          // act
          await classUnderTest.removeExpression(expressionModels.first.id);

          // assert
          var expressions = await database.select(database.expressions).get();
          expect(expressions, equals(expressionModels.skip(1).toList()));
        },
      );

      test(
        'should remove an expression from the mascot-expression map',
        () async {
          // arrange
          await database.into(database.mascots).insert(
                context.data.mapMascotToMascotModel.map(
                  context.data.mascot.copyWith(
                    expressions: {context.data.mascot.expressions.first},
                  ),
                ),
              );
          await database.into(database.mascotExpressionMaps).insert(
                MascotExpressionMapsCompanion(
                  mascotId: Value(context.data.mascot.id),
                  expressionId: Value(context.data.mascot.expressions.first.id),
                ),
              );
          await classUnderTest.upsertExpression(expressionModel);

          // act
          await classUnderTest.removeExpression(expressionModel.id);

          // assert
          var map = await database.select(database.mascotExpressionMaps).get();
          expect(map, isEmpty);
        },
      );
    });

    group('getExpressions', () {
      test(
        'should get expressions',
        () async {
          // arrange
          await classUnderTest.upsertExpressions(expressionModels);
          var expressionModels2 = expressionModels.map((e) {
            return DriftExpression(
              id: 0,
              name: 'test ${e.id}',
              description: 'test ${e.id}',
              image: Uint8List(5),
            );
          }).toList();
          await classUnderTest.upsertExpressions(expressionModels2);

          // act
          var expressions = await classUnderTest
              .getExpressions(expressionModels.map((e) => e.id).toList());

          // assert
          expect(expressions, equals(expressionModels));
        },
      );
    });

    group('streamExpressions', () {
      test(
        'should emit DriftExpression when expression is added',
        () async {
          // arrange
          var expressionIds = expressionModels.map((e) => e.id);
          var stream = classUnderTest.streamExpressions(expressionIds);

          // act
          await classUnderTest.upsertExpressions(expressionModels);

          // assert
          await expectLater(
            stream,
            emits(expressionModels),
          );
        },
      );

      test(
        'should emit DriftExpression when expression is updated',
        () async {
          // arrange
          var expressionIds = expressionModels.map((e) => e.id);
          var stream = classUnderTest.streamExpressions(expressionIds);
          await classUnderTest.upsertExpressions(expressionModels);
          var expressionModel2 = DriftExpression(
            id: 1,
            name: 'new expression name',
            description: 'new expression description',
            image: Uint8List(6),
          );

          // ac
          await classUnderTest.upsertExpression(expressionModel2);

          // assert
          await expectLater(
            stream,
            emits([
              expressionModel2,
              ...expressionModels.where((e) => e.id != expressionModel2.id),
            ]),
          );
        },
      );
    });
  });
}
