import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/collection_adapter.dart';
import '../models/expression_model.dart';

abstract class ExpressionsLocalDataSource {
  /// Saves an image to the local database.
  Future<Id> addExpression(ExpressionModel image);

  /// Gets an image from the local database.
  Future<ExpressionModel> getExpression(Id id);

  /// Removes an image from the local database.
  Future<void> removeExpression(Id id);

  /// Gets several images from the local database.
  Future<List<ExpressionModel>> getExpressions(List<Id> ids);
}

@Injectable(as: ExpressionsLocalDataSource)
class ImagesLocalDataSourceImpl implements ExpressionsLocalDataSource {
  final CollectionAdapter<ExpressionModel> collection;

  ImagesLocalDataSourceImpl(this.collection);

  @override
  Future<ExpressionModel> getExpression(Id id) => collection.get(id);

  @override
  Future<Id> addExpression(ExpressionModel image) => collection.add(image);

  @override
  Future<void> removeExpression(Id id) => collection.remove(id);

  @override
  Future<List<ExpressionModel>> getExpressions(List<Id> ids) =>
      collection.getMany(ids);
}
