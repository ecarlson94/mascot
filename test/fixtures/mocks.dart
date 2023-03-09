import 'package:hive/hive.dart';
import 'package:isar/isar.dart' as isar;
import 'package:isar/isar.dart';
import 'package:mascot/core/data/collection_adapter.dart';
import 'package:mascot/features/expressions/data/datasources/expressions_local_data_source.dart';
import 'package:mascot/features/expressions/data/models/expression_model.dart';
import 'package:mascot/features/expressions/domain/repositories/expressions_repository.dart';
import 'package:mascot/features/mascot/data/datasources/mascots_local_data_source.dart';
import 'package:mascot/features/mascot/data/models/mascot_model.dart';
import 'package:mascot/features/mascot/domain/repositories/mascots_repository.dart';
import 'package:mascot/features/mascot/domain/usecases/get_mascot.dart';
import 'package:mascot/features/mascot/domain/usecases/save_mascot.dart';
import 'package:mascot/features/mascot/domain/usecases/stream_mascot.dart';
import 'package:mascot/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:mascot/features/settings/data/models/settings_model.dart';
import 'package:mascot/features/settings/domain/repositories/settings_repository.dart';
import 'package:mascot/features/settings/domain/usecases/stream_settings.dart';
import 'package:mockito/annotations.dart';

import 'mocks.mocks.dart';
import 'test_model.dart';

@GenerateNiceMocks([
  MockSpec<Isar>(unsupportedMembers: {#txnSync, #writeTxnSync}),
  MockSpec<CollectionAdapter<ExpressionModel>>(
    as: #MockExpressionsCollectionAdapter,
  ),
  MockSpec<CollectionAdapter<MascotModel>>(as: #MockMascotsCollectionAdapter),
  MockSpec<CollectionAdapter<SettingsModel>>(
    as: #MockSettingsCollectionAdapter,
  ),
])
@GenerateMocks([
  ExpressionsRepository,
  ExpressionsLocalDataSource,
  MascotsLocalDataSource,
  isar.IsarCollection<TestModel>,
  Box<TestModel>,
  HiveInterface,
  MascotsRepository,
  SaveMascot,
  GetMascot,
  SettingsRepository,
  StreamSettings,
  SettingsLocalDataSource,
  StreamMascot,
])
class Mocks {
  MockIsar? _isar;
  MockIsar get isar => _isar ??= MockIsar();

  MockExpressionsRepository? _expressionsRepository;
  MockExpressionsRepository get expressionsRepository =>
      _expressionsRepository ??= MockExpressionsRepository();

  MockExpressionsLocalDataSource? _expressionsLocalDataSource;
  MockExpressionsLocalDataSource get expressionsLocalDataSource =>
      _expressionsLocalDataSource ??= MockExpressionsLocalDataSource();

  MockMascotsLocalDataSource? _mascotsLocalDataSource;
  MockMascotsLocalDataSource get mascotsLocalDataSource =>
      _mascotsLocalDataSource ??= MockMascotsLocalDataSource();

  MockIsarCollection<TestModel>? _isarTestCollection;
  MockIsarCollection<TestModel> get isarTestCollection =>
      _isarTestCollection ??= MockIsarCollection();

  MockBox<TestModel>? _hiveTestCollection;
  MockBox<TestModel> get hiveTestCollection =>
      _hiveTestCollection ??= MockBox();

  MockBox<ExpressionModel>? _hiveImageBox;
  MockBox<ExpressionModel> get hiveImageBox => _hiveImageBox ??= MockBox();

  MockBox<MascotModel>? _hiveMascotBox;
  MockBox<MascotModel> get hiveMascotBox => _hiveMascotBox ??= MockBox();

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

  MockBox<SettingsModel>? _hiveSettingsBox;
  MockBox<SettingsModel> get hiveSettingsBox => _hiveSettingsBox ??= MockBox();

  MockSettingsCollectionAdapter? _settingsCollectionAdapter;
  MockSettingsCollectionAdapter get settingsCollectionAdapter =>
      _settingsCollectionAdapter ??= MockSettingsCollectionAdapter();

  MockSettingsLocalDataSource? _settingsLocalDataSource;
  MockSettingsLocalDataSource get settingsLocalDataSource =>
      _settingsLocalDataSource ??= MockSettingsLocalDataSource();

  MockStreamMascot? _streamMascot;
  MockStreamMascot get streamMascot => _streamMascot ??= MockStreamMascot();
}
