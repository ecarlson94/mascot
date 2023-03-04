import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/collection_adapter.dart';
import '../models/mascot_model.dart';

abstract class MascotLocalDataSource {
  /// Saves a mascot to the local database.
  Future<Id> addMascot(MascotModel mascot);

  /// Gets a mascot from the local database.
  Future<MascotModel> getMascot(Id? id);
}

@LazySingleton(as: MascotLocalDataSource)
class MascotLocalDataSourceImpl implements MascotLocalDataSource {
  final CollectionAdapter<MascotModel> collection;

  MascotLocalDataSourceImpl(this.collection);

  @override
  Future<MascotModel> getMascot(Id? id) => collection.get(id);

  @override
  Future<Id> addMascot(MascotModel mascot) => collection.add(mascot);
}
