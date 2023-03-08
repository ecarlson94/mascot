import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/collection_adapter.dart';
import '../models/mascot_model.dart';

abstract class MascotsLocalDataSource {
  /// Saves a mascot to the local database.
  Future<Id> addMascot(MascotModel mascot);

  /// Gets a mascot from the local database.
  Future<MascotModel> getMascot(Id id);

  // Stream a mascot from the local database.
  Future<Stream<MascotModel?>> streamMascot(Id id);
}

@Injectable(as: MascotsLocalDataSource)
class MascotsLocalDataSourceImpl implements MascotsLocalDataSource {
  final CollectionAdapter<MascotModel> collection;

  MascotsLocalDataSourceImpl(this.collection);

  @override
  Future<MascotModel> getMascot(Id id) => collection.get(id);

  @override
  Future<Id> addMascot(MascotModel mascot) => collection.add(mascot);

  @override
  Future<Stream<MascotModel?>> streamMascot(Id id) => collection.stream(id);
}
