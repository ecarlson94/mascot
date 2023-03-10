import 'package:injectable/injectable.dart';

import '../../../../../core/clean_architecture/entity.dart';
import '../../../../../core/data/hive/hive_collection_adapter.dart';
import '../../models/mascot_model.dart';

abstract class MascotsHiveDataSource {
  /// Saves a mascot to the local database.
  Future<Id> addMascot(MascotModel mascot);

  /// Gets a mascot from the local database.
  Future<MascotModel> getMascot(Id id);

  // Stream a mascot from the local database.
  Future<Stream<MascotModel?>> streamMascot(Id id);
}

@Injectable(as: MascotsHiveDataSource)
class MascotsHiveDataSourceImpl implements MascotsHiveDataSource {
  final HiveCollectionAdapter<MascotModel> collection;

  MascotsHiveDataSourceImpl(this.collection);

  @override
  Future<MascotModel> getMascot(Id id) => collection.get(id);

  @override
  Future<Id> addMascot(MascotModel mascot) => collection.add(mascot);

  @override
  Future<Stream<MascotModel?>> streamMascot(Id id) => collection.stream(id);
}
