import 'package:injectable/injectable.dart';

import '../../../../../core/clean_architecture/entity.dart';
import '../../../../../core/data/indexed_db/indexed_db_data_source.dart';
import '../../models/mascot_model.dart';

@lazySingleton
class MascotsIndexedDbDataSource extends IndexedDbDataSourceImpl<MascotModel> {
  MascotsIndexedDbDataSource(super.indexedDbFactory, super.settings);

  @override
  MascotModel fromJson(Map<String, dynamic> json) {
    return MascotModel(
      id: json['id'] as int,
      name: json['name'] as String,
      expressionIds: Set<Id>.from(json['expressionsIds'] as List<int>),
    );
  }

  @override
  Map<String, dynamic> toJson(MascotModel object) {
    return {
      'id': object.id,
      'name': object.name,
      'expressionIds': object.expressionIds.toList(),
    };
  }
}
