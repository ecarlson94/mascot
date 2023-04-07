import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/data/indexed_db/indexed_db_data_source.dart';
import 'package:mascot/features/expressions/data/datasources/indexed_db/expressions_indexed_db_data_source.dart';
import 'package:mascot/features/expressions/data/models/expression_model.dart';

import '../../../../core/data/indexed_db/indexed_db_data_source_test.dart';

void main() {
  late TestIdbFactory indexedDbFactory;
  late ExpressionsIndexedDbDataSource dataSource;

  setUp(() async {
    indexedDbFactory = TestIdbFactory();
    dataSource =
        ExpressionsIndexedDbDataSource(indexedDbFactory, IndexDbSettings());
    Type testType = ExpressionModel;
    await indexedDbFactory.factory!.deleteDatabase(testType.toString());
  });

  group('ExpressionsIndexedDbDataSource', () {
    group('fromJson', () {
      test('should return ExpressionModel when provided with valid JSON', () {
        // arrange
        final json = {
          'id': 1,
          'name': 'Test',
          'description': 'Test description',
          'image': [1, 2, 3, 4],
        };

        // act
        final result = dataSource.fromJson(json);

        // assert
        expect(result, isA<ExpressionModel>());
        expect(result.id, json['id']);
        expect(result.name, json['name']);
        expect(result.description, json['description']);
        expect(result.image, Uint8List.fromList(json['image'] as List<int>));
      });
    });

    group('toJson', () {
      test('should return a JSON object from the provided ExpressionModel', () {
        // arrange
        final expression = ExpressionModel(
          id: 1,
          name: 'Test',
          description: 'Test description',
          image: Uint8List.fromList([1, 2, 3, 4]),
        );

        // act
        final result = dataSource.toJson(expression);

        // assert
        expect(result, isA<Map<String, dynamic>>());
        expect(result['id'], expression.id);
        expect(result['name'], expression.name);
        expect(result['description'], expression.description);
        expect(result['image'], expression.image.toList());
      });
    });
  });
}
