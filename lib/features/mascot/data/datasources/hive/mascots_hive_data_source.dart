import 'package:injectable/injectable.dart';

import '../../../../../core/clean_architecture/entity.dart';
import '../../../../../core/data/hive/hive_collection_adapter.dart';
import '../../models/mascot_model.dart';
import 'models/hive_mascot.dart';
import 'models/map_mascot_to_hive_mascot.dart';

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
  final HiveCollectionAdapter<HiveMascot> _mascots;
  final MapMascotToHiveMascot _mapMascotToHiveMascot;

  MascotsHiveDataSourceImpl(this._mascots, this._mapMascotToHiveMascot);

  @override
  Future<MascotModel> getMascot(Id id) => _mascots.get(id);

  @override
  Future<Id> addMascot(MascotModel mascot) =>
      _mascots.add(_mapMascotToHiveMascot.map(mascot));

  @override
  Future<Stream<MascotModel?>> streamMascot(Id id) => _mascots.stream(id);
}
