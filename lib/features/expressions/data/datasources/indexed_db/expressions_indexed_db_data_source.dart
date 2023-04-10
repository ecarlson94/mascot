import 'dart:typed_data';

import 'package:injectable/injectable.dart';

import '../../../../../core/data/indexed_db/indexed_db_data_source.dart';
import '../../../domain/entities/expression.dart';
import '../../models/expression_model.dart';

@lazySingleton
class ExpressionsIndexedDbDataSource
    extends IndexedDbDataSourceImpl<ExpressionModel> {
  ExpressionsIndexedDbDataSource(super.indexedDbFactory, super.settings);

  @override
  ExpressionModel fromJson(Map<String, dynamic> json) {
    var image = json['image'];
    return ExpressionModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      image: Uint8List.fromList(
        image is List<int> ? image : (image as List<dynamic>).cast<int>(),
      ),
      priority: json['priority'] as int,
      activator: ExpressionTriggers.values.firstWhere(
        (element) => element.toString() == json['activator'] as String,
      ),
    );
  }

  @override
  Map<String, dynamic> toJson(ExpressionModel object) {
    return {
      'id': object.id,
      'name': object.name,
      'description': object.description,
      'image': object.image.toList(),
      'priority': object.priority,
      'activator': object.activator.toString(),
    };
  }
}
