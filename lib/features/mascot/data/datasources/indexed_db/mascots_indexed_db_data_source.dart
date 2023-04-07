import 'package:injectable/injectable.dart';

import '../../../../../core/data/indexed_db/indexed_db_data_source.dart';
import '../../../../expressions/data/models/expression_model.dart';
import '../../models/mascot_model.dart';

// TODO: Add tests
@lazySingleton
class MascotsIndexedDbDataSource extends IndexedDbDataSourceImpl<MascotModel> {
  MascotsIndexedDbDataSource(super.indexedDbFactory, super.settings);

  @override
  MascotModel fromJson(Map<String, dynamic> json) {
    return MascotModel(
      id: json['id'] as int,
      name: json['name'] as String,
      expressions: (json['expressions'] as List)
          .map((e) => ExpressionModel.empty().copyWith(id: e as int))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson(MascotModel object) {
    return {
      'id': object.id,
      'name': object.name,
      'expressions': object.expressions.map((e) => e.id).toList(),
    };
  }
}
