import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/hive/hive_collection_adapter.dart';
import 'models/hive_expression.dart';
import 'models/hive_image.dart';

@module
abstract class ExpressionsCollection {
  @singleton
  @preResolve
  Future<Box<HiveExpression>> create(
    HiveInterface hive,
  ) async {
    hive.registerAdapter(HiveImageAdapter());
    hive.registerAdapter(HiveExpressionAdapter());
    return hive.openBox<HiveExpression>('expressions');
  }
}

@module
abstract class ExpressionsCollectionAdapter {
  @factoryMethod
  HiveCollectionAdapter<HiveExpression> create(
    Box<HiveExpression> collection,
  ) {
    return HiveCollectionAdapter<HiveExpression>(collection);
  }
}
