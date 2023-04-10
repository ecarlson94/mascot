import 'package:mascot/core/utils/logger.dart';
import 'package:mascot/features/expressions/data/datasources/indexed_db/expressions_indexed_db_data_source.dart';
import 'package:mascot/features/expressions/domain/repositories/expressions_repository.dart';
import 'package:mascot/features/expressions/domain/services/expression_animation_service.dart';
import 'package:mascot/features/mascot/data/datasources/indexed_db/mascots_indexed_db_data_source.dart';
import 'package:mascot/features/mascot/data/repositories/mascots_repository_impl.dart';
import 'package:mascot/features/mascot/domain/repositories/mascots_repository.dart';
import 'package:mascot/features/mascot/domain/usecases/get_mascot.dart';
import 'package:mascot/features/mascot/domain/usecases/add_mascot.dart';
import 'package:mascot/features/mascot/domain/usecases/stream_mascot.dart';
import 'package:mascot/features/microphone/device/microphone.dart';
import 'package:mascot/features/microphone/domain/services/microphone_service.dart';
import 'package:mascot/features/microphone/domain/usecases/stream_microphone_volume.dart';
import 'package:mascot/features/settings/data/datasources/indexded_db/settings_indexed_db_data_source.dart';
import 'package:mascot/features/settings/domain/repositories/settings_repository.dart';
import 'package:mascot/features/settings/domain/usecases/save_talking_threshold.dart';
import 'package:mascot/features/settings/domain/usecases/stream_settings.dart';
import 'package:mockito/annotations.dart';

import 'mocks.mocks.dart';

@GenerateMocks([
  ExpressionsIndexedDbDataSource,
  ExpressionsRepository,
  SettingsIndexedDbDataSource,
  MascotsIndexedDbDataSource,
  MascotsRepository,
  AddMascot,
  GetMascot,
  SettingsRepository,
  StreamSettings,
  SaveTalkingThreshold,
  StreamMascot,
  Logger<MascotsRepositoryImpl>,
  MicrophoneService,
  Microphone,
  StreamMicrophoneVolume,
  ExpressionAnimationService,
])
class Mocks {
  MockExpressionsIndexedDbDataSource? _expressionsLocalDataSource;
  MockExpressionsIndexedDbDataSource get expressionsLocalDataSource =>
      _expressionsLocalDataSource ??= MockExpressionsIndexedDbDataSource();

  MockExpressionsRepository? _expressionsRepository;
  MockExpressionsRepository get expressionsRepository =>
      _expressionsRepository ??= MockExpressionsRepository();

  MockMascotsIndexedDbDataSource? _mascotsLocalDataSource;
  MockMascotsIndexedDbDataSource get mascotsLocalDataSource =>
      _mascotsLocalDataSource ??= MockMascotsIndexedDbDataSource();

  MockMascotsRepository? _mascotsRepository;
  MockMascotsRepository get mascotsRepository =>
      _mascotsRepository ??= MockMascotsRepository();

  MockAddMascot? _addMascot;
  MockAddMascot get addMascot => _addMascot ??= MockAddMascot();

  MockGetMascot? _getMascot;
  MockGetMascot get getMascot => _getMascot ??= MockGetMascot();

  MockSettingsRepository? _settingsRepository;
  MockSettingsRepository get settingsRepository =>
      _settingsRepository ??= MockSettingsRepository();

  MockStreamSettings? _streamSettings;
  MockStreamSettings get streamSettings =>
      _streamSettings ??= MockStreamSettings();

  MockSaveTalkingThreshold? _saveTalkingThreshold;
  MockSaveTalkingThreshold get saveTalkingThreshold =>
      _saveTalkingThreshold ??= MockSaveTalkingThreshold();

  MockStreamMascot? _streamMascot;
  MockStreamMascot get streamMascot => _streamMascot ??= MockStreamMascot();

  MockSettingsIndexedDbDataSource? _settingsLocalDataSource;
  MockSettingsIndexedDbDataSource get settingsLocalDataSource =>
      _settingsLocalDataSource ??= MockSettingsIndexedDbDataSource();

  MockLogger<T> getLogger<T>() => MockLogger<T>();

  MockMicrophoneService? _microphoneService;
  MockMicrophoneService get microphoneService =>
      _microphoneService ??= MockMicrophoneService();

  MockMicrophone? _microphone;
  MockMicrophone get microphone => _microphone ??= MockMicrophone();

  MockStreamMicrophoneVolume? _streamMicrophoneVolume;
  MockStreamMicrophoneVolume get streamMicrophoneVolume =>
      _streamMicrophoneVolume ??= MockStreamMicrophoneVolume();

  MockExpressionAnimationService? _expressionAnimationService;
  MockExpressionAnimationService get expressionAnimationService =>
      _expressionAnimationService ??= MockExpressionAnimationService();
}
