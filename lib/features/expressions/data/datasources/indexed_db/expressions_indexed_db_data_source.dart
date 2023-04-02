import 'dart:typed_data';

import 'package:injectable/injectable.dart';

import '../../../../../core/data/indexed_db/indexed_db_data_source.dart';
import '../../models/expression_model.dart';

@lazySingleton
class ExpressionsIndexedDbDataSource
    extends IndexedDbDataSourceImpl<ExpressionModel> {
  ExpressionsIndexedDbDataSource(super.indexedDbFactory, super.settings);

  @override
  ExpressionModel fromJson(Map<String, dynamic> json) {
    return ExpressionModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      image: Uint8List.fromList(json['image'] as List<int>),
    );
  }

  @override
  Map<String, dynamic> toJson(ExpressionModel object) {
    return {
      'id': object.id,
      'name': object.name,
      'description': object.description,
      'image': object.image.toList(),
    };
  }
}
