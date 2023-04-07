import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/clean_architecture/entity.dart';
import 'package:mascot/core/data/indexed_db/indexed_db_data_source.dart';
import 'package:mascot/features/expressions/data/models/expression_model.dart';
import 'package:mascot/features/mascot/data/datasources/indexed_db/mascots_indexed_db_data_source.dart';
import 'package:mascot/features/mascot/data/models/mascot_model.dart';

import '../../../../../core/data/indexed_db/indexed_db_data_source_test.dart';

void main() {
  late TestIdbFactory indexedDbFactory;
  late MascotsIndexedDbDataSource dataSource;

  setUp(() async {
    indexedDbFactory = TestIdbFactory();
    dataSource =
        MascotsIndexedDbDataSource(indexedDbFactory, IndexDbSettings());
    Type testType = MascotModel;
    await indexedDbFactory.factory!.deleteDatabase(testType.toString());

    testType = ExpressionModel;
    await indexedDbFactory.factory!.deleteDatabase(testType.toString());
  });

  group('MascotsIndexedDbDataSource', () {
    group('fromJson', () {
      test('should return MascotModel when provided with valid JSON', () {
        // arrange
        final json = {
          'id': 1,
          'name': 'Test Mascot',
          'expressions': [1, 2, 3],
        };

        // act
        final result = dataSource.fromJson(json);

        // assert
        var expressions = json['expressions'] as List<Id>;
        expect(result, isA<MascotModel>());
        expect(result.id, json['id']);
        expect(result.name, json['name']);
        expect(result.expressions.length, expressions.length);
        for (int i = 0; i < result.expressions.length; i++) {
          expect(result.expressions[i].id, expressions[i]);
        }
      });
    });

    group('toJson', () {
      test('should return a JSON object from the provided MascotModel', () {
        // arrange
        final mascot = MascotModel(
          id: 1,
          name: 'Test Mascot',
          expressions: [
            ExpressionModel.empty().copyWith(id: 1),
            ExpressionModel.empty().copyWith(id: 2),
            ExpressionModel.empty().copyWith(id: 3),
          ],
        );

        // act
        final result = dataSource.toJson(mascot);

        // assert
        expect(result, isA<Map<String, dynamic>>());
        expect(result['id'], mascot.id);
        expect(result['name'], mascot.name);
        expect(result['expressions'].length, mascot.expressions.length);
        for (int i = 0; i < result['expressions'].length; i++) {
          expect(result['expressions'][i], mascot.expressions[i].id);
        }
      });
    });
  });
}
