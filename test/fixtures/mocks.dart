import 'package:mascot/core/utils/logger.dart';
import 'package:mascot/features/expressions/data/datasources/drift/expressions_drift_data_source.dart';
import 'package:mascot/features/mascot/data/datasources/drift/mascots_drift_data_source.dart';
import 'package:mascot/features/mascot/data/repositories/mascots_repository_impl.dart';
import 'package:mascot/features/mascot/domain/repositories/mascots_repository.dart';
import 'package:mascot/features/mascot/domain/usecases/get_mascot.dart';
import 'package:mascot/features/mascot/domain/usecases/save_mascot.dart';
import 'package:mascot/features/mascot/domain/usecases/stream_mascot.dart';
import 'package:mascot/features/microphone/device/microphone.dart';
import 'package:mascot/features/microphone/domain/services/microphone_service.dart';
import 'package:mascot/features/settings/data/datasources/drift/settings_drift_data_source.dart';
import 'package:mascot/features/settings/domain/repositories/settings_repository.dart';
import 'package:mascot/features/settings/domain/usecases/stream_settings.dart';
import 'package:mockito/annotations.dart';

import 'mocks.mocks.dart';

@GenerateMocks([
  ExpressionsDriftDataSource,
  SettingsDriftDataSource,
  MascotsDriftDataSource,
  MascotsRepository,
  SaveMascot,
  GetMascot,
  SettingsRepository,
  StreamSettings,
  StreamMascot,
  Logger<MascotsRepositoryImpl>,
  MicrophoneService,
  Microphone,
])
class Mocks {
  MockExpressionsDriftDataSource? _expressionsLocalDataSource;
  MockExpressionsDriftDataSource get expressionsLocalDataSource =>
      _expressionsLocalDataSource ??= MockExpressionsDriftDataSource();

  MockMascotsDriftDataSource? _mascotsLocalDataSource;
  MockMascotsDriftDataSource get mascotsLocalDataSource =>
      _mascotsLocalDataSource ??= MockMascotsDriftDataSource();

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

  MockStreamMascot? _streamMascot;
  MockStreamMascot get streamMascot => _streamMascot ??= MockStreamMascot();

  MockSettingsDriftDataSource? _settingsLocalDataSource;
  MockSettingsDriftDataSource get settingsLocalDataSource =>
      _settingsLocalDataSource ??= MockSettingsDriftDataSource();

  MockLogger<T> getLogger<T>() => MockLogger<T>();

  MockMicrophoneService? _microphoneService;
  MockMicrophoneService get microphoneService =>
      _microphoneService ??= MockMicrophoneService();

  MockMicrophone? _microphone;
  MockMicrophone get microphone => _microphone ??= MockMicrophone();
}
