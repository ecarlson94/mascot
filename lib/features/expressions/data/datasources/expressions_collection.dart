import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

import '../../../../core/data/collection_adapter.dart';
import '../../../../core/data/hive_collection_adapter.dart';
import '../models/expression_model.dart';
import '../models/image_model.dart';

// @module // Uncomment when enabling Isar
abstract class IsarExpressionsCollection {
  @lazySingleton
  IsarCollection<ExpressionModel> create(Isar isar) {
    return isar.collection<ExpressionModel>();
  }
}

@module
abstract class HiveExpressionsCollection {
  @singleton
  @preResolve
  Future<Box<ExpressionModel>> create(
    HiveInterface hive,
  ) async {
    hive.registerAdapter(ImageModelAdapter());
    hive.registerAdapter(ExpressionModelAdapter());
    return hive.openBox<ExpressionModel>('expressions');
  }
}

@module
abstract class ExpressionsCollectionAdapter {
  @factoryMethod
  CollectionAdapter<ExpressionModel> create(
    Box<ExpressionModel> collection,
  ) {
    return HiveCollectionAdapter<ExpressionModel>(collection);
  }
}
