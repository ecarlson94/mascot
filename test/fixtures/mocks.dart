import 'package:hive/hive.dart';
import 'package:isar/isar.dart' as isar;
import 'package:isar/isar.dart';
import 'package:mascot/core/data/hive/hive_collection_adapter.dart';
import 'package:mascot/features/expressions/data/datasources/hive/expressions_hive_data_source.dart';
import 'package:mascot/features/expressions/data/datasources/hive/models/hive_expression.dart';
import 'package:mascot/features/expressions/domain/repositories/expressions_repository.dart';
import 'package:mascot/features/mascot/data/datasources/hive/mascots_hive_data_source.dart';
import 'package:mascot/features/mascot/data/datasources/hive/models/hive_mascot.dart';
import 'package:mascot/features/mascot/domain/repositories/mascots_repository.dart';
import 'package:mascot/features/mascot/domain/usecases/get_mascot.dart';
import 'package:mascot/features/mascot/domain/usecases/save_mascot.dart';
import 'package:mascot/features/mascot/domain/usecases/stream_mascot.dart';
import 'package:mascot/features/settings/data/datasources/hive/models/hive_settings.dart';
import 'package:mascot/features/settings/data/datasources/hive/settings_hive_data_source.dart';
import 'package:mascot/features/settings/domain/repositories/settings_repository.dart';
import 'package:mascot/features/settings/domain/usecases/stream_settings.dart';
import 'package:mockito/annotations.dart';

import 'mocks.mocks.dart';
import 'test_model.dart';

@GenerateNiceMocks([
  MockSpec<Isar>(unsupportedMembers: {#txnSync, #writeTxnSync}),
  MockSpec<HiveCollectionAdapter<HiveExpression>>(
    as: #MockExpressionsCollectionAdapter,
  ),
  MockSpec<HiveCollectionAdapter<HiveMascot>>(
    as: #MockMascotsCollectionAdapter,
  ),
  MockSpec<HiveCollectionAdapter<HiveSettings>>(
    as: #MockSettingsCollectionAdapter,
  ),
])
@GenerateMocks([
  ExpressionsRepository,
  ExpressionsHiveDataSource,
  MascotsHiveDataSource,
  isar.IsarCollection<TestModel>,
  Box<TestModel>,
  HiveInterface,
  MascotsRepository,
  SaveMascot,
  GetMascot,
  SettingsRepository,
  StreamSettings,
  SettingsHiveDataSource,
  StreamMascot,
])
class Mocks {
  MockIsar? _isar;
  MockIsar get isar => _isar ??= MockIsar();

  MockExpressionsRepository? _expressionsRepository;
  MockExpressionsRepository get expressionsRepository =>
      _expressionsRepository ??= MockExpressionsRepository();

  MockExpressionsHiveDataSource? _expressionsHiveDataSource;
  MockExpressionsHiveDataSource get expressionsHiveDataSource =>
      _expressionsHiveDataSource ??= MockExpressionsHiveDataSource();

  MockMascotsHiveDataSource? _mascotsHiveSource;
  MockMascotsHiveDataSource get mascotsLocalDataSource =>
      _mascotsHiveSource ??= MockMascotsHiveDataSource();

  MockIsarCollection<TestModel>? _isarTestCollection;
  MockIsarCollection<TestModel> get isarTestCollection =>
      _isarTestCollection ??= MockIsarCollection();

  MockBox<HiveTestModel>? _hiveTestCollection;
  MockBox<HiveTestModel> get hiveTestCollection =>
      _hiveTestCollection ??= MockBox();

  MockBox<HiveExpression>? _hiveImageBox;
  MockBox<HiveExpression> get hiveImageBox => _hiveImageBox ??= MockBox();

  MockBox<HiveMascot>? _hiveMascotBox;
  MockBox<HiveMascot> get hiveMascotBox => _hiveMascotBox ??= MockBox();

  MockExpressionsCollectionAdapter? _expressionsCollectionAdapter;
  MockExpressionsCollectionAdapter get expressionsCollectionAdapter =>
      _expressionsCollectionAdapter ??= MockExpressionsCollectionAdapter();

  MockMascotsCollectionAdapter? _mascotsCollectionAdapter;
  MockMascotsCollectionAdapter get mascotsCollectionAdapter =>
      _mascotsCollectionAdapter ??= MockMascotsCollectionAdapter();

  MockHiveInterface? _hiveInterface;
  MockHiveInterface get hiveInterface => _hiveInterface ??= MockHiveInterface();

  MockMascotsRepository? _mascotsRepository;
  MockMascotsRepository get mascotsRepository =>
      _mascotsRepository ??= MockMascotsRepository();

  MockSaveMascot? _saveMascot;
  MockSaveMascot get saveMascot => _saveMascot ??= MockSaveMascot();

  MockGetMascot? _getMascot;
  MockGetMascot get getMascot => _getMascot ??= MockGetMascot();

  MockSettingsRepository? _settingsRepository;
  MockSettingsRepository get settingsRepository =>
      _settingsRepository ??= MockSettingsRepository();

  MockStreamSettings? _streamSettings;
  MockStreamSettings get streamSettings =>
      _streamSettings ??= MockStreamSettings();

  MockBox<HiveSettings>? _hiveSettingsBox;
  MockBox<HiveSettings> get hiveSettingsBox => _hiveSettingsBox ??= MockBox();

  MockSettingsCollectionAdapter? _settingsCollectionAdapter;
  MockSettingsCollectionAdapter get settingsCollectionAdapter =>
      _settingsCollectionAdapter ??= MockSettingsCollectionAdapter();

  MockSettingsHiveDataSource? _settingsHiveDataSource;
  MockSettingsHiveDataSource get settingsHiveDataSource =>
      _settingsHiveDataSource ??= MockSettingsHiveDataSource();

  MockStreamMascot? _streamMascot;
  MockStreamMascot get streamMascot => _streamMascot ??= MockStreamMascot();
}
