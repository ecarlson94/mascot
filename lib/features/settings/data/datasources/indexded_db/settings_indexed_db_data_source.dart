import 'package:injectable/injectable.dart';

import '../../../../../core/data/indexed_db/indexed_db_data_source.dart';
import '../../models/settings_model.dart';

@lazySingleton
class SettingsIndexedDbDataSource
    extends IndexedDbDataSourceImpl<SettingsModel> {
  SettingsIndexedDbDataSource(super.indexedDbFactory, super.settings);

  @override
  SettingsModel fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      id: json['id'] as int,
      favoriteMascotId: json['favoriteMascotId'] as int?,
    );
  }

  @override
  Map<String, dynamic> toJson(SettingsModel object) {
    return {
      'id': object.id,
      'favoriteMascotId': object.favoriteMascotId,
    };
  }
}
