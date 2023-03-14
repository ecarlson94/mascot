import 'package:injectable/injectable.dart';

import '../../../../../core/clean_architecture/entity.dart';
import '../../../../../core/data/hive/hive_collection_adapter.dart';
import '../../../../expressions/data/datasources/hive/expressions_hive_data_source.dart';
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
  final ExpressionsHiveDataSource _expressions;
  final MapMascotToHiveMascot _mapMascotToHiveMascot;

  MascotsHiveDataSourceImpl(
    this._mascots,
    this._expressions,
    this._mapMascotToHiveMascot,
  );

  @override
  Future<MascotModel> getMascot(Id id) async {
    var mascot = await _mascots.get(id);
    return await _applyExpressions(mascot);
  }

  @override
  Future<Id> addMascot(MascotModel mascot) async {
    var mascotWithEmptyExpressions = mascot.copyWith(
      expressions: mascot.expressions.map((e) => e.copyWith(id: e.id)).toSet(),
    );
    var mascotToSave = _mapMascotToHiveMascot.map(mascotWithEmptyExpressions);
    var mascotId = await _mascots.add(_mapMascotToHiveMascot.map(mascotToSave));

    for (var expression in mascot.expressions) {
      await _expressions.addExpression(expression);
    }

    return mascotId;
  }

  // TODO: Stream mascot should also stream expressions
  @override
  Future<Stream<MascotModel?>> streamMascot(Id id) async =>
      (await _mascots.stream(id)).asyncMap(
        (event) async => event == null ? event : await _applyExpressions(event),
      );

  Future<HiveMascot> _applyExpressions(
    HiveMascot hiveMascot,
  ) async {
    List<Id> expressionIds = hiveMascot.expressions.map((e) => e.id).toList();
    if (expressionIds.isEmpty) return hiveMascot;

    var expressions = await _expressions.getExpressions(expressionIds);
    var mascot = hiveMascot.copyWith(expressions: expressions.toSet());

    return _mapMascotToHiveMascot.map(mascot);
  }
}
