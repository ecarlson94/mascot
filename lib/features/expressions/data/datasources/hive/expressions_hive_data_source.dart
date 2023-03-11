import 'package:injectable/injectable.dart';

import '../../../../../core/clean_architecture/entity.dart';
import '../../../../../core/data/hive/hive_collection_adapter.dart';
import '../../models/expression_model.dart';
import 'models/hive_expression.dart';
import 'models/map_expression_to_hive_expression.dart';

abstract class ExpressionsHiveDataSource {
  /// Saves an image to the local database.
  Future<Id> addExpression(ExpressionModel image);

  /// Gets an image from the local database.
  Future<ExpressionModel> getExpression(Id id);

  /// Removes an image from the local database.
  Future<void> removeExpression(Id id);

  /// Gets several images from the local database.
  Future<List<ExpressionModel>> getExpressions(List<Id> ids);
}

@Injectable(as: ExpressionsHiveDataSource)
class ExpressionsHiveDataSourceImpl implements ExpressionsHiveDataSource {
  final HiveCollectionAdapter<HiveExpression> collection;
  final MapExpressionToHiveExpression mapExpressionToHiveExpression;

  ExpressionsHiveDataSourceImpl(
    this.collection,
    this.mapExpressionToHiveExpression,
  );

  @override
  Future<ExpressionModel> getExpression(Id id) => collection.get(id);

  @override
  Future<Id> addExpression(ExpressionModel expression) =>
      collection.add(mapExpressionToHiveExpression.map(expression));

  @override
  Future<void> removeExpression(Id id) => collection.remove(id);

  @override
  Future<List<ExpressionModel>> getExpressions(List<Id> ids) =>
      collection.getMany(ids);
}
